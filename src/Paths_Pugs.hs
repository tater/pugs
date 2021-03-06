module Paths_Pugs where
import System.FilePath
import System.Directory
import Pugs.Version (versnum)
import Pugs.Config
import qualified Data.Map as Map

getDataFileName :: FilePath -> IO FilePath
getDataFileName fn = do
    dir <- case Map.lookup "sourcedir" config of
       Just rv -> return rv
       _       -> fail "Cannot find 'sourcedir' in config!"
    rvf <- doesFileExist $ dir </> fn
    rvd <- doesDirectoryExist $ dir </> fn
    if rvf || rvd then return (dir </> fn) else do
        _cabal <- getAppUserDataDirectory "cabal"
        createDirectoryIfMissing True $ path _cabal
        return $ path _cabal
    where
    path cabal = foldl1 (</>) [cabal, "share", "Pugs-" ++ versnum, fn]
