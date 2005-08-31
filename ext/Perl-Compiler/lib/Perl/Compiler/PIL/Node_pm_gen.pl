
=pod
This file is the beginning of a full PIL node definition for perl6.
Since macros cannot currently define classes,
   macro f($x) { "class $x \{};" }  f("C");  C.new
   Error: No compatible subroutine found: "&C" 
It is currently a source code generator.
30 Aug 2005
=cut

# XXX - macro's cant currently define classes, so...
BEGIN{ say "\n# autogenerated file. DO NOT EDIT.  pugsbug workaround\n\n"; }

macro node ($data,$constructor,*@fields) {
    my $code = "class $constructor \{";
    for @fields -> $n,$t { $code ~= "\n  has \$.$n;"; }
    $code ~= "\n}\n";
    say $code; # XXX - see above
    $code;
}
macro instance (*@xx) { "" }
macro singleton (*@xx) { "" }

# src/Pugs/PIL1.hs data

node 'PIL_Environment',      'PIL_Environment', 
  'pilGlob' ,'[PIL_Decl]',
  'pilMain' ,'PIL_Stmts';

node 'PIL_Stmts',            'PNil';
node 'PIL_Stmts',            'PStmts', 
  'pStmt'  ,'PIL_Stmt',
  'pStmts' ,'PIL_Stmts';
node 'PIL_Stmts',            'PPad', 
  'pScope' ,'Scope',
  'pSyms'  ,'[(VarName, PIL_Expr)]',
  'pStmts' ,'PIL_Stmts';

node 'PIL_Stmt',             'PNoop';
node 'PIL_Stmt',             'PStmt', 
  'pExpr' ,'PIL_Expr';
node 'PIL_Stmt',             'PPos', 
  'pPos'  ,'Pos',
  'pExp'  ,'Exp',
  'pNode' ,'PIL_Stmt';

node 'PIL_Expr',             'PRawName', 
  'pRawName' ,'VarName';
node 'PIL_Expr',             'PExp', 
  'pLV'   ,'PIL_LValue';
node 'PIL_Expr',             'PLit', 
  'pLit'  ,'PIL_Literal';
node 'PIL_Expr',             'PThunk', 
  'pThunk' ,'PIL_Expr';
node 'PIL_Expr',             'PCode', 
  'pType'   ,'SubType',
  'pParams' ,'[TParam]',
  'pLValue' ,'Bool',
  'pBody'   ,'PIL_Stmts';

node 'PIL_Decl',             'PSub', 
  'pSubName'   ,'SubName',
  'pSubType'   ,'SubType',
  'pSubParams' ,'[TParam]',
  'pSubLValue' ,'Bool',
  'pSubBody'   ,'PIL_Stmts';

node 'PIL_Literal',          'PVal', 
  'pVal'  ,'Val';

node 'PIL_LValue',           'PVar', 
  'pVarName' ,'VarName';
node 'PIL_LValue',           'PApp', 
  'pCxt'  ,'TCxt',
  'pFun'  ,'PIL_Expr',
  'pInv'  ,'(Maybe PIL_Expr)',
  'pArgs' ,'[PIL_Expr]';
node 'PIL_LValue',           'PAssign', 
  'pLHS'  ,'[PIL_LValue]',
  'pRHS'  ,'PIL_Expr';
node 'PIL_LValue',           'PBind', 
  'pLHS'  ,'[PIL_LValue]',
  'pRHS'  ,'PIL_Expr';

node 'TParam',               'MkTParam', 
  'tpParam'   ,'Param',
  'tpDefault' ,'(Maybe (PIL_Expr))';

node 'TCxt',                 'TCxtVoid';
node 'TCxt',                 'TCxtLValue',
  'nemo', 'Type';
node 'TCxt',                 'TCxtItem',
  'nemo', 'Type';
node 'TCxt',                 'TCxtSlurpy',
  'nemo', 'Type';
node 'TCxt',                 'TTailCall',
  'nemo', 'TCxt';

node 'TEnv',                 'MkTEnv', 
  'tLexDepth' ,'Int',
  'tTokDepth' ,'Int',
  'tCxt'      ,'TCxt',
  'tReg'      ,'(TVar (Int, String))',
  'tLabel'    ,'(TVar Int)';

# src/Pugs/PIL1.hs DrIFT stuff

singleton 'Scope', 'SState';
singleton 'Scope', 'SMy';
singleton 'Scope', 'SOur';
singleton 'Scope', 'SLet';
singleton 'Scope', 'STemp';
singleton 'Scope', 'SGlobal';

singleton 'SubType', 'SubMethod';
singleton 'SubType', 'SubCoroutine';
singleton 'SubType', 'SubMacro';
singleton 'SubType', 'SubRoutine';
singleton 'SubType', 'SubBlock';
singleton 'SubType', 'SubPointy';
singleton 'SubType', 'SubPrim';

instance 'Val', 'VUndef';
instance 'Val', 'VBool' ,'unk';
instance 'Val', 'VInt'  ,'unk';
instance 'Val', 'VRat'  ,'unk';
instance 'Val', 'VNum'  ,'unk';
instance 'Val', 'VStr'  ,'unk';
instance 'Val', 'VList' ,'unk';
instance 'Val', 'VType' ,'unk';

instance 'Cxt', 'CxtVoid';
instance 'Cxt', 'CxtItem'   ,'unk';
instance 'Cxt', 'CxtSlurpy' ,'unk';

instance 'Type', 'MkType'  ,'unk';
instance 'Type', 'TypeOr'  ,'(unk, unk)';
instance 'Type', 'TypeAnd' ,'(unk, unk)';

# instance Param and Pos are presented as MkParam and MkPos.

node 'Param', 'MkParam',
  'isInvocant'   ,'unk',
  'isOptional'   ,'unk',
  'isNamed'      ,'unk',
  'isLValue'     ,'unk',
  'isWritable'   ,'unk',
  'isLazy'       ,'unk',
  'paramName'    ,'unk',
  'paramContext' ,'unk',
  'paramDefault' ,'unk';

node 'Pos', 'MkPos',
  'posName'        ,'unk',
  'posBeginLine'   ,'unk',
  'posBeginColumn' ,'unk',
  'posEndLine'     ,'unk',
  'posEndColumn'   ,'unk';
