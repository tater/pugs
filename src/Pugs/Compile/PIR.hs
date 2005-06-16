{-# OPTIONS_GHC -fglasgow-exts -fno-warn-orphans -funbox-strict-fields -cpp #-}

module Pugs.Compile.PIR (genPIR') where
import Pugs.Compile.Parrot
import Pugs.Internals
import Pugs.AST
import Emit.PIR
import Pugs.Pretty
import Text.PrettyPrint

#ifndef HADDOCK
data PAST a where
    PVal        :: !Val -> PAST Literal
    PVar        :: !VarName -> PAST LValue
    PExp        :: !(PAST LValue) -> PAST Expression 
    PLit        :: !(PAST Literal) -> PAST Expression
    PStmts      :: !(PAST Stmt) -> PAST [Stmt] -> PAST [Stmt]
    PNil        :: PAST [a]
    PNoop       :: PAST Stmt
    PPos        :: !Pos -> !Exp -> PAST a -> PAST a
    PStmt       :: !(PAST Expression) -> PAST Stmt 
    PApp        :: !(PAST Expression) -> ![PAST Expression] -> PAST LValue
    PAssign     :: ![PAST LValue] -> !(PAST Expression) -> PAST Expression
    PBind       :: ![PAST LValue] -> !(PAST Expression) -> PAST Expression
    PPad        :: ![(VarName, PAST Expression)] -> !(PAST [Stmt]) -> PAST [Stmt]
    PThunk      :: !(PAST Expression) -> PAST Expression 
    PRaw        :: !Exp -> PAST Stmt -- XXX HACK!
    PRawName    :: !VarName -> PAST Expression -- XXX HACK!
#endif

instance Show (PAST a) where
    show (PVal x) = "(PVal " ++ show x ++ ")"
    show (PVar x) = "(PVar " ++ show x ++ ")"
    show (PLit x) = "(PLit " ++ show x ++ ")"
    show (PStmts x y) = "(PStmts " ++ show x ++ " " ++ show y ++ ")"
    show PNil = "PNil"
    show PNoop = "PNoop"
    show (PPos x y z) = "(PPos " ++ show x ++ " " ++ show y ++ " " ++ show z ++ ")"
    show (PApp x y) = "(PApp " ++ show x ++ " " ++ show y ++ ")"
    show (PExp x) = "(PExp " ++ show x ++ ")"
    show (PStmt x) = "(PStmt " ++ show x ++ ")"
    show (PAssign x y) = "(PAssign " ++ show x ++ " " ++ show y ++ ")"
    show (PBind x y) = "(PBind " ++ show x ++ " " ++ show y ++ ")"
    show (PPad x y) = "(PPad " ++ show x ++ " " ++ show y ++ ")"
    show (PThunk x) = "(PThunk " ++ show x ++ ")"
    show (PRaw x) = "(PRaw " ++ show x ++ ")"
    show (PRawName x) = "(PRawName " ++ show x ++ ")"

data TEnv = MkTEnv
    { tLexDepth :: !Int
    , tTokDepth :: !Int
    , tEnv      :: !Env
    , tReg      :: !(TVar Int)
    , tLabel    :: !(TVar Int)
    }
    deriving (Show, Eq)

type Comp a = Eval a
type Trans a = WriterT [Stmt] (ReaderT TEnv IO) a

class (Show a, Typeable b) => Compile a b where
    compile :: a -> Comp (PAST b)
    compile x = fail ("Unrecognized construct: " ++ show x)

class (Show a, Typeable b) => Translate a b | a -> b where
    trans :: a -> Trans b
    trans _ = fail "Untranslatable construct!"

instance Compile [(TVar Bool, TVar VRef)] Expression where
    compile _ = return (PLit $ PVal undef)

instance Compile (String, [(TVar Bool, TVar VRef)]) Expression where
    compile (name, _) = return $ PRawName name

instance Compile Exp [Stmt] where
    compile (Pos pos rest) = fmap (PPos pos rest) $ compile rest
    compile (Stmts (Pad SMy pad exp) rest) = do
        expC    <- compile $ mergeStmts exp rest
        padC    <- mapM compile (padToList pad)
        return $ PPad ((map fst (padToList pad)) `zip` padC) expC
    compile (Stmts first rest) = do
        firstC  <- compile first
        restC   <- compileStmts rest
        return $ PStmts firstC restC
    compile exp = do
        liftIO $ do
            putStrLn "*** Unknown expression:"
            putStr "    "
            putStrLn $ show exp
        return PNil

compileStmts :: Exp -> Comp (PAST [Stmt])
compileStmts exp = case exp of
    Stmts this rest -> do
        thisC   <- compile this
        restC   <- compileStmts rest
        return $ PStmts thisC restC
    Noop        -> return PNil
    _           -> compile (Stmts exp Noop)

instance Compile Exp Stmt where
    compile (Pos pos rest) = fmap (PPos pos rest) $ compile rest
    compile Noop = return PNoop
    compile (Val val) = do
        compile val :: Comp (PAST Literal)
        warn "Literal value used in constant expression" val
        compile Noop
    compile (Syn "loop" [exp]) =
        compile (Syn "loop" $ [emptyExp, Val (VBool True), emptyExp, exp])
{-
    compile (Syn "loop" [pre, cond, post, body]) = do
        preC  <- compile pre
        -- bodyC <- compile body
        -- postC <- compile post
        -- condC <- compile cond
        return $ PStmt preC
-}
    compile exp@(Syn "loop" _) = return $ PRaw exp
    compile exp = fmap PStmt $ compile exp
    -- compile exp = error ("invalid stmt: " ++ show exp)

instance Compile Exp LValue where
    compile (Pos pos rest) = fmap (PPos pos rest) $ compile rest
    compile (Var name) = return $ PVar name
    compile (App fun Nothing args) = do
        funC    <- compile fun
        argsC   <- mapM compile args
        return $ PApp funC argsC
    compile (Syn "if" [cond, true, false]) = do
        condC   <- compile cond :: Comp (PAST Expression)
        trueC   <- compile true :: Comp (PAST Expression)
        falseC  <- compile false :: Comp (PAST Expression)
        funC    <- compile (Var "&statement_control:if")
        return $ PApp funC [condC, PThunk trueC, PThunk falseC]
    compile exp = error ("Invalid LValue: " ++ show exp)

instance Compile Exp Expression where
    compile (Pos pos rest) = fmap (PPos pos rest) $ compile rest
    compile (Var name) = return . PExp $ PVar name
    compile (Val val) = fmap PLit (compile val)
    compile exp@(App _ _ _) = fmap PExp $ compile exp
    compile exp@(Syn "if" _) = fmap PExp $ compile exp
    compile Noop = compile (Val undef)
    compile (Syn "=" [lhs, rhs]) = do
        lhsC    <- compile lhs
        rhsC    <- compile rhs
        return $ PAssign [lhsC] rhsC
    compile exp = compError exp

compError :: forall a b. Compile a b => a -> Comp (PAST b)
compError = die ("Compile error -- invalid " ++ show (typeOf (undefined :: b)))

transError :: forall a b. Translate a b => a -> Trans b
transError = die ("Translate error -- invalid " ++ show (typeOf (undefined :: b)))

instance Compile Val Literal where
    compile val = return $ PVal val

die :: (MonadIO m, Show a) => String -> a -> m b
die x y = do
    warn x y
    liftIO $ exitFailure

warn :: (MonadIO m, Show a) => String -> a -> m ()
warn str val = liftIO $ do
    hPutStrLn stderr $ "*** " ++ str ++ ":\n    " ++ show val

instance (Typeable a) => Translate (PAST a) a where
    trans PNil = return []
    trans PNoop = return (StmtComment "")
    trans (PPos pos exp rest) = do
        -- tell [StmtLine (posName pos) (posBeginLine pos)]
        dep <- asks tTokDepth
        tell [StmtComment $ (replicate dep ' ') ++ "{{{ " ++ pretty exp]
        x   <- local (\e -> e{ tTokDepth = dep + 1 }) $ trans rest
        tell [StmtComment $ (replicate dep ' ') ++ "}}} " ++ pretty pos]
        return x
    trans (PLit (PVal VUndef)) = do
        pmc     <- genLV
        return (ExpLV pmc)
    trans (PLit lit) = do
        -- generate fresh supply and things...
        litC    <- trans lit
        pmc     <- genLV
        tellIns $ InsAssign pmc (ExpLit litC)
        return (ExpLV pmc)
    trans (PVal (VStr str)) = return $ LitStr str
    trans (PVal (VInt int)) = return $ LitInt int
    trans (PVal (VNum num)) = return $ LitNum num
    trans (PVal (VRat rat)) = return $ LitNum (ratToNum rat)
    trans val@(PVal _) = transError val
    trans (PVar name) = do
        pmc     <- genLV
        tellIns $ pmc <-- "find_name" $ [lit name]
        return pmc
    trans (PStmt (PExp (PApp (PExp (PVar name)) args))) = do
        argsC   <- mapM trans args
        return $ StmtIns $ InsFun [] (lit name) argsC
    trans (PStmt (PLit (PVal VUndef))) = return $ StmtComment ""
    trans (PStmt exp) = do
        expC    <- trans exp
        return $ StmtIns $ InsExp expC
    trans (PAssign [lhs] rhs) = do
        lhsC    <- trans lhs
        rhsC    <- trans rhs
        tellIns $ InsAssign lhsC rhsC
        return (ExpLV lhsC)
    trans (PStmts this rest) = do
        thisC   <- trans this
        tell [thisC]
        restC   <- trans rest
        tell restC
        return []
    trans (PApp fun args) = do
        funC    <- trans fun
        argsC   <- mapM trans args
        pmc     <- genLV
        -- XXX - probe if funC is slurpy, then modify ExpLV pmc accordingly
        tellIns $ [reg pmc] <-& funC $ argsC
        return pmc
    trans (PPad pad exps) = do
        valsC   <- mapM trans (map snd pad)
        pass $ do
            expsC   <- trans exps
            return ([], (StmtPad (map fst pad `zip` valsC) expsC:))
    trans (PExp exp) = fmap ExpLV $ trans exp
    trans (PThunk exp) = do
        [begC, sndC, retC, endC] <- genLabel ["thunkBegin", "thunkAgain", "thunkReturn", "thunkEnd"]
        thunk   <- genPMC
        tellIns $ "newsub" .- [reg thunk, bare ".Continuation", bare begC]
        tellIns $ "goto" .- [bare endC]
        tellIns $ InsLabel begC Nothing
        cc      <- genPMC
        tellIns $ "get_params" .- sigList [reg cc]
        expC    <- trans exp
        tellIns $ "set_addr" .- [reg thunk, bare sndC]
        tellIns $ "goto" .- [bare retC]
        tellIns $ InsLabel sndC Nothing
        tellIns $ "get_params" .- sigList [reg cc]
        tellIns $ InsLabel retC . Just $ "set_returns" .- [lit "(0b10)", expC]
        tellIns $ "invoke" .- [reg cc]
        tellIns $ InsLabel endC Nothing
        return (ExpLV thunk)
    -- XXX HACK!
    trans (PRaw exp) = do
        env <- asks tEnv
        raw <- liftIO $ runEvalIO env{ envStash = "$P0" } $ do
            doc <- compile' exp
            return $ VStr (render doc)
        return $ StmtRaw (text $ vCast raw)
    trans (PRawName name) = do
        -- generate fresh supply and things...
        pmc     <- genName name
        return (ExpLV pmc)
    trans x = transError x

tellIns :: Ins -> Trans ()
tellIns = tell . (:[]) . StmtIns

genPMC :: (RegClass a) => Trans a
genPMC = do
    tvar    <- asks tReg
    pmc     <- liftIO $ liftSTM $ do
        cur <- readTVar tvar
        writeTVar tvar (cur + 1)
        return (PMC cur)
    return $ reg pmc

genLV :: (RegClass a) => Trans a
genLV = do
    pmc <- genPMC
    tellIns $ InsNew pmc PerlUndef
    return $ reg pmc

genLabel :: [String] -> Trans [LabelName]
genLabel names = do
    tvar    <- asks tLabel
    cnt     <- liftIO $ liftSTM $ do
        cur <- readTVar tvar
        writeTVar tvar (cur + 1)
        return cur
    return $ map (\name -> "LABEL_" ++ show cnt ++ "_" ++ name) names

genName :: (RegClass a) => String -> Trans a
genName name = do
    let var = render $ varText name
    tvar    <- asks tReg
    tellIns $ InsLocal RegPMC var
    tellIns $ InsNew (VAR var) (read $ render $ varInit name)
    return $ reg (VAR var)

genPIR' :: Eval Val
genPIR' = do
    env         <- ask
    past        <- compile (envBody env) :: (Eval (PAST [Stmt]))
    zero        <- liftSTM $ newTVar 100
    none        <- liftSTM $ newTVar 0
    let initEnv = MkTEnv
            { tLexDepth = 0
            , tTokDepth = 0
            , tEnv      = env
            , tReg      = zero
            , tLabel    = none
            }
    (_, pir)    <- liftIO $ (`runReaderT` initEnv) $ runWriterT (trans past)
    return . VStr . unlines $
        [ "#!/usr/bin/env parrot"
        -- , renderStyle (Style PageMode 0 0) init
        , renderStyle (Style PageMode 0 0) $ preludePIR $+$ vcat
            [ text ".sub main @MAIN"
            , text "    new_pad 0"
            , nest 4 (emit pir)
            , text ".end"
            ]
        ]

