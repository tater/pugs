{-# OPTIONS_GHC -fglasgow-exts -fth -cpp -package plugins -package hi #-}

module External.Haskell where
import AST

#undef PUGS_HAVE_TH
#include "../pugs_config.h"
#if !defined(PUGS_HAVE_TH) || !defined(PUGS_HAVE_HSPLUGINS)
externalizeHaskell :: String -> String -> IO String
externalizeHaskell  = error "Template Haskell support not compiled in"
loadHaskell :: FilePath -> IO [(String, [Val] -> Eval Val)]
loadHaskell         = error "Template Haskell support not compiled in"
#else

import Internals
import Language.Haskell.TH as TH
import Language.Haskell.Parser
import Language.Haskell.Syntax
import Plugins
import Config

{- ourPackageConfigs :: [PackageConfig]
ourPackageConfigs = [
    PackageConfig {
        hs_libraries = ["Unicode.o"]
        extra_libraries = ["UnicodeC.o"]
    }
] -}
ourPackageConfigs = []

loadOrDie 
     :: FilePath                -- ^ object file
     -> [FilePath]              -- ^ any include paths
     -> [FilePath]              -- ^ list of package.conf paths
     -> String                  -- ^ symbol to find
     -> IO (a)
loadOrDie obj includes configs symbol = do
    stat <- load obj includes configs symbol
    case stat of
        LoadFailure errs -> error $ unlines $ ["Error loading "++symbol++" from "++obj] ++ errs
        LoadSuccess _ a  -> return a

loadHaskell :: FilePath -> IO [(String, [Val] -> Eval Val)]
loadHaskell file = do
    let coredir   = getConfig "installarchlib" ++ "/CORE/pugs/"
    let loadpaths = [coredir, getConfig "installsitearch"]
    -- For Unicode
    loadRawObject $ coredir++"UnicodeC.o"
    -- For RRegex
    loadRawObject $ coredir++"pcre/pcre.o"
    
    -- AST has early requirements and late requirements, because of recrusivity.  
    -- The logic for this should probably be moved to hs-plugins, but do it here 
    -- for now.
    mapM 
        (\n -> load (coredir++n++".o") loadpaths ourPackageConfigs "")
        ["Compat", "Cont", "Embed", "Embed/Perl5", "Internals", "RRegex", "RRegex/PCRE", "RRegex/Syntax", "Rule/Pos", "UTF8", "Unicode", "AST"]

    (extern :: [String]) <- loadOrDie file loadpaths ourPackageConfigs "extern__"
    print (">"++(show extern)++"<")
    (`mapM` extern) $ \name -> do
        func <- loadOrDie file loadpaths ourPackageConfigs ("extern__" ++ name)
        return (name, func)

externalizeHaskell :: String -> String -> IO String
externalizeHaskell mod code = do
    let names = map snd exports
    symTable <- runQ [d| extern__ = names |]
    symDecls <- mapM wrap names
    return $ unlines $
        [ "module " ++ mod ++ " where"
        , "import Internals"
        , "import GHC.Base"
        , "import AST"
        , ""
        , code
        , ""
        , "-- below are automatically generated by Pugs --"
        , TH.pprint symTable
        , TH.pprint symDecls
        ] 
    where
    exports :: [(HsQualType, String)]
    exports = concat [ [ (typ, name) | HsIdent name <- names ]
                     | HsTypeSig _ names typ <- parsed
                     ]
    parsed = case parseModule code of
        ParseOk (HsModule _ _ _ _ decls) -> decls
        ParseFailed _ err -> error err

wrap :: String -> IO Dec
wrap fun = do
    [quoted] <- runQ [d|
            name = \[v] -> do
                s <- fromVal v
                return (castV ($(dyn fun) s))
        |]
    return $ munge quoted ("extern__" ++ fun)

munge (ValD _ x y) name = ValD (VarP (mkName name)) x y
munge _ _ = error "impossible"



#endif
