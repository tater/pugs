{-# OPTIONS -fglasgow-exts #-}

{-
    Higher-level parser for building ASTs.

    I sang of leaves, of leaves of gold, and leaves of gold there grew:
    Of wind I sang, a wind there came and in the branches blew.
    Beyond the Sun, beyond the Moon, the foam was on the Sea,
    And by the strand of Ilmarin there grew a golden Tree...
-}

module Parser where
import Internals
import AST
import Lexer

type StateParser a = GenParser Char () a

tightOperators =
    [ methOps  " . .+ .? .* .+ .() .[] .{} .<<>> .= "   -- Method postfix
    , postOps  " ++ -- "                                -- Auto-Increment
    , rightOps " ** "                                   -- Exponentiation
    , preOps   " ! + - ~ ? * ** +^ ~^ ?^ \\ "           -- Symbolic Unary
    , leftOps  " * / % x xx +& +< +> ~& ~< ~> "         -- Multiplicative
    , leftOps  " + - ~ +| +^ ~| ~^ "                    -- Additive
    , leftOps  " & ! "                                  -- Junctive And
    , leftOps  " ^ | "                                  -- Junctive Or
    , preOps   primitiveUnaryFunctions                  -- Name Unary
    , leftOps  " but does "                             -- Traits
      ++ noneOps " => but does cmp <=> .. ^.. ..^ ^..^ "-- Non-chaining Binary
      ++ postOps "..."                                  -- Infinite range
    , chainOps $
               " != == < <= > >= ~~ !~ " ++
               " eq ne lt le gt ge =:= "                -- Chained Binary
    , leftOps  " && "                                   -- Tight And
    , leftOps  " || ^^ // "                             -- Tight Or
    , ternOps  [("??", "::")]                           -- Ternary
    , leftSyn  " = := ::= += **= xx= "                  -- Assignment
    ]

looseOperators =
    [ preOps   primitiveListFunctions                   -- List Operator
    , leftOps  " ==> "                                  -- Pipe Forward
    , leftOps  " and "                                  -- Loose And
    , leftOps  " or xor err "                           -- Loose Or
    ]

operators :: OperatorTable Char () Exp
operators = concat $
    [ tightOperators
    , [ listOps  " , " ]                                -- Comma
    , looseOperators
    , [ listSyn  " ; " ]                                -- Terminator
    ]

litOperators = tightOperators ++ looseOperators

primitiveListFunctions = " not <== any all one none"

parseExp = parseTerm

parseOp = buildExpressionParser operators parseTerm
parseLitOp = buildExpressionParser litOperators parseLitTerm

ops f s = [f n | n <- words s]

doApp str args = App str [] args

preOps      = ops $ makeOp1 Prefix "&prefix:" doApp
postOps     = ops $ makeOp1 Postfix "&postfix:" doApp
leftOps     = ops $ makeOp2 AssocLeft "&infix:" doApp
rightOps    = ops $ makeOp2 AssocRight "&infix:" doApp
noneOps     = ops $ makeOp2 AssocNone "&infix:" doApp
listOps     = leftOps
chainOps    = leftOps
leftSyn     = ops $ makeOp2 AssocLeft "&infix:" Syn
rightSyn    = ops $ makeOp2 AssocRight "&infix:" Syn
listSyn     = leftSyn
chainSyn    = leftSyn

-- chainOps    = ops $ makeOpChained

makeOp1 prec sigil con name = prec $ do
    reservedOp name
    return $ \x -> con (sigil ++ name) [x]

makeOp2 prec sigil con name = (`Infix` prec) $ do
    reservedOp name
    return $ \x y -> con (sigil ++ name) [x,y]

parseParens parse = do
    cs <- parens parse
    return $ Parens cs

parseTerm = choice
    [ parseDecl
    , parseVar
    , parseLit
    , parseApply
    , parseParens parseOp
    ]
    <?> "term"

parseLitTerm = choice
    [ parseVar
    , parseLit
    , parseApply
    , parseParens parseLitOp
    ]
    <?> "argument"

parseTrait trait = do
    symbol "is"
    symbol trait
    identifier

parseBareTrait trait = do
    choice [ parseTrait trait
           , do { symbol trait ; identifier }
           ]

parseContext = do
    lead    <- upper
    rest    <- many1 wordAny
    return (lead:rest)

parseParamDefault True  = return $ Val VUndef
parseParamDefault False = option (Val VUndef) $ do
    symbol "="
    parseLitOp

parseFormalParam = do
    cxt     <- option "" $ parseContext
    sigil   <- option "" $ choice . map string $ words " ? * + ++ "
    name    <- parseVarName
    let required = (sigil /=) `all` ["?", "+"]
    exp     <- parseParamDefault required
    return $ buildParam cxt sigil name exp

parseApply = lexeme $ do
    name            <- identifier
    (invs:args:_)   <- parseParamList parseLitTerm
    return $ App ('&':name) invs args

parseParamList parse = do
    formal <- maybeParens ((parse `sepBy` symbol ",") `sepBy` symbol ":")
    case formal of
        []                  -> return [[], []]
        [args]              -> return [[], args]
        [invocants,args]    -> return formal
        _                   -> fail "Only one invocant list allowed"

parseFormalParameters = do
    (invs:args:_) <- parseParamList parseFormalParam
    return $ (map (\e -> e { isInvocant = True }) invs) ++ args

nameToParam :: String -> Param
nameToParam name = Param
    { isInvocant    = False
    , isSlurpy      = (name == "$_")
    , isOptional    = False
    , isNamed       = False
    , paramName     = name
    , paramContext  = (if name == "$_" then "List" else "Scalar")
    , paramDefault  = Val VUndef
    }

parseDecl = lexeme $ do
    multi   <- option False $ do { symbol "multi" ; return True }
    symbol "sub"
    pos     <- getPosition
    name    <- identifier
    cxt     <- option "Any" $ parseBareTrait "returns"
    formal  <- option Nothing $ return . Just =<< parens parseFormalParameters
    body    <- braces parseOp
    let (fun, names) = extract (body,[])
        params = (maybe [] id formal) ++ map nameToParam names
    -- Check for placeholder vs formal parameters
    unless (isNothing formal || null names || names == ["$_"] ) $
        fail "Cannot mix placeholder variables with formal parameters"
    let sub = Sub { isMulti       = multi
                  , subType       = SubRoutine
                  , subAssoc      = "pre"
                  , subReturns    = cxt
                  , subParams     = if null params then [defaultArrayParam] else params
                  , subFun        = fun
                  }
    return $ Syn "&infix:::=" [Var ('&':name) pos, Val (VSub sub)]

maybeParens p = choice [ parens p, p ]

parseVarName = lexeme $ do
    sigil   <- oneOf "$@%&"
    caret   <- option "" $ choice [ string "^", string "*" ]
    name    <- many1 wordAny
    return $ (sigil:caret) ++ name

parseVar = do
    pos     <- getPosition
    name    <- parseVarName
    return $ Var name pos

nonTerm = do
    pos <- getPosition
    return $ NonTerm pos

parseLit = choice
    [ numLiteral
    , strLiteral
    , arrayLiteral
--  , pairLiteral
    , namedLiteral "undef"  VUndef
    , namedLiteral "NaN"    (VNum $ 0/0)
    , namedLiteral "Inf"    (VNum $ 1/0)
    ]

numLiteral = do
    n <- naturalOrRat  
    case n of
        Left  i -> return . Val $ VInt i
        Right d -> return . Val $ VRat d

strLiteral = return . Val . VStr =<< stringLiteral

arrayLiteral = do
    items <- brackets $ parseOp `sepBy` symbol ","
    return $ App "&prefix:\\" [] [(Parens $ foldl app (Val $ VList []) items)]
    where
    app :: Exp -> Exp -> Exp
    app x y = App "&infix:," [] [x, y]

pairLiteral = do
    key <- identifier
    symbol "=>"
    val <- parseTerm
    return $ Syn "&infix:=>" [Val (VStr key), val]

namedLiteral n v = do { symbol n; return $ Val v }

op_methodPostfix    = []
op_namedUnary       = []
methOps _ = []
primitiveUnaryFunctions = []
ternOps _ = []

-- runLex :: Show a => StateParser a -> String -> IO ()
runLex f p input
        = runParse f (do{ whiteSpace
                 ; x <- p
                 ; eof
                 ; return x
                 }) input

-- run :: Show a => StateParser a -> String -> IO ()
runParse f p input
        = case ( runParser p () "" input ) of
            Left err -> do{ putStr "parse error at "
                          ; print err
                          }
            Right x  -> f x

