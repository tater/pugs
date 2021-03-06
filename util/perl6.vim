" Vim syntax file
" Language:     Perl 6
" Last Change:  Nov 25th 2008
" Contributors: Luke Palmer <fibonaci@babylonia.flatirons.org>
"               Moritz Lenz <moritz@faui2k3.org>
"               Hinrik Örn Sigurðsson <hinrik.sig@gmail.com>
"                
" This is a big undertaking. Perl 6 is the sort of language that only Perl
" can parse. But I'll do my best to get vim to.
"
" You can associate the extension ".pl" with the filetype "perl6" by setting
"     autocmd BufNewFile,BufRead *.pl setf perl6
" in your ~/.vimrc.

" Die if there's already a defined syntax
" if exists("b:current_syntax")
"   finish
" endif
"
" TODO:
"   * syntax for reading from stdin: =<> or from arbitrary file handles:
"     =<$fh>
"   * List initialization via the @a = <foo bar> construct brakes when there
"     is a newline between '<' and '>'
"   * The regex regex_name { ... } syntax for regexes/tokens seems to be
"     unsupported
"   * Improve POD formatting codes support (S<>, etc) 

" Recommended formatting options (see pugs::hack)
setlocal autoindent expandtab smarttab shiftround shiftwidth=4 softtabstop=4

" Billions of keywords
syn keyword p6Attn          ACHTUNG ATTN ATTENTION FIXME NB contained 
syn keyword p6Attn          todo Todo TODO WTF XXX contained
" XXX 'subset declares a type, but not a module - how should it be classified?
syn keyword p6Module        module class role use require package enum grammar subset
syn keyword p6KeyDecl       macro sub submethod method is but does trusts multi only
syn keyword p6KeyDecl       rule token regex category
syn keyword p6KeyScopeDecl  let my our state temp has constant proto
syn keyword p6KeyFlow       if else elsif unless  
syn keyword p6KeyFlow       for foreach loop repeat while until when next last redo
syn keyword p6KeyFlow       given not or and andthen orelse xor return default
syn keyword p6KeyFlow       exit make
syn keyword p6ClosureTrait  BEGIN CHECK INIT START FIRST ENTER LEAVE KEEP UNDO NEXT LAST
syn keyword p6ClosureTrait  PRE POST END rw signature returns of parsed cached 
syn keyword p6ClosureTrait  readonly ref copy 
syn keyword p6ClosureTrait  inline tighter looser equiv assoc
syn keyword p6ClosureTrait  deep also
syn keyword p6KeyException  die fail try CATCH CONTROL warn
syn keyword p6KeyIO         print open read write readline say seek close slurp
syn keyword p6KeyIO         opendir readdir
syn keyword p6KeyProperty   constant prec key value irs ofs ors pos export
syn keyword p6KeyProperty   float int str true false int1 int2 int4 int8
syn keyword p6KeyProperty   int16 int32 int64 uint1 uint2 uint4 uint8 uint16
syn keyword p6KeyProperty   uint32 uint64 num16 num32 num64 complex16 complex32
syn keyword p6KeyProperty   complex64 complex128 buf8 buf16 buf32 buf64
syn keyword p6KeyProperty   WHAT HOW
syn keyword p6KeyType       Array Bool Class Code Hash Int IO Num NumRange 
syn keyword p6KeyType       Str StrRange Sub Role Rule Rat Complex Any
syn keyword p6KeyType       Scalar List 
syn keyword p6KeyFunc       substr index rindex
syn keyword p6KeyFunc       grep map sort join split reduce min max reverse truncate zip
syn keyword p6KeyFunc       cat roundrobin classify first 
syn keyword p6KeyFunc       keys values pairs defined delete exists elems end kv
syn keyword p6KeyFunc       arity assuming gather take any pick all none one wrap
syn keyword p6KeyFunc       callsame callwith nextsame nextwith
syn keyword p6KeyFunc       pop push shift splice unshift  
syn keyword p6KeyFunc       abs exp log log10 rand sign sqrt sin cos tan       
syn keyword p6KeyFunc       floor ceil round srand roots cis unpolar polar
syn keyword p6KeyFunc       p5chop chop p5chomp chomp lc lcfirst uc ucfirst
syn keyword p6KeyFunc       capitalize normalize pack unpack quotemeta comb
syn keyword p6KeyFunc       nfd nfc nfkd nfkc
syn keyword p6KeyFunc       printf sprintf caller evalfile run runinstead 
syn keyword p6KeyFunc       nothing want bless chr ord list item gmtime 
syn keyword p6KeyFunc       localtime time gethost getpw chroot getlogin kill
syn keyword p6KeyFunc       fork wait perl context
syn keyword p6KeySpecial    eval operator undef undefine 
syn keyword p6KeySpecial    infix postfix prefix cirumfix postcircumfix
syn keyword p6KeyCompare    eq ne lt le gt ge cmp == != < <= > >=
syn match   p6Normal        "\w*::\w\+"

" Comments
syn match  p6Comment "#.*" contains=p6Attn
syn match  p6Shebang "^#!.*"

" Pod

" Abbreviated blocks
syn region p6PodAbbrRegion
    \ matchgroup=p6PodCommand
    \ start="^=\ze\S\+\>"
    \ end="^\ze\(\s*$\|=\k\)"
    \ contains=p6PodAbbrType
    \ keepend

syn region p6PodAbbrType
    \ matchgroup=p6PodType
    \ start="\S\+\>"
    \ end="^\ze\(\s*$\|=\k\)"
    \ contains=p6PodAbbr
    \ contained

syn region p6PodAbbr
    \ start=""
    \ end="^\ze\(\s*$\|=\k\)"
    \ contains=@p6PodAmbient
    \ contained

" Directives
syn region p6PodDirectRegion
    \ matchgroup=p6PodCommand
    \ start="^=\(config\|use\|encoding\)\>"
    \ end="^\ze\([^=]\|=\S\|$\)"
    \ contains=p6PodDirectTypeRegion
    \ keepend

syn region p6PodDirectTypeRegion
    \ matchgroup=p6PodType
    \ start="\S\+"
    \ end="^\ze\([^=]\|=\S\|$\)"
    \ contains=p6PodDirectConfigRegion
    \ contained

syn region p6PodDirectConfigRegion
    \ matchgroup=p6PodConfig
    \ start=""
    \ end="^\ze\([^=]\|=\S\|$\)"
    \ contains=p6PodConfig,p6PodExtraConfigLeader
    \ contained

" Delimited blocks
syn region p6PodDelimRegion
    \ matchgroup=p6PodCommand
    \ start="^=begin\>"
    \ end="^=end\>"
    \ contains=p6PodDelimTypeRegion

syn region p6PodDelimTypeRegion
    \ matchgroup=p6PodType
    \ start="\S\+"
    \ end="^\ze=end\>"
    \ contains=p6PodDelim,p6PodDelimConfigRegion
    \ contained

syn region p6PodDelimConfigRegion
    \ matchgroup=p6PodConfig
    \ start=""
    \ end="^\ze\([^=]\|=\S\|$\)"
    \ contains=p6PodConfig,p6PodExtraConfigLeader
    \ contained

syn region p6PodDelim
    \ start="^"
    \ end="^\ze=end\>"
    \ contains=@p6PodNested,@p6PodAmbient
    \ contained

syn region p6PodDelimEndRegion
    \ start="\(^=end\>\)\@<="
    \ end="\S\+"

" Paragraph blocks
syn region p6PodParaRegion
    \ matchgroup=p6PodCommand
    \ start="^=for\>"
    \ end="^\ze\(\s*\|=\S\)"
    \ contains=p6PodParaTypeRegion

syn region p6PodParaTypeRegion
    \ matchgroup=p6PodType
    \ start="\S\+"
    \ end="^\ze\(\s*$\|=\S\)"
    \ contains=p6PodPara,p6PodParaConfigRegion
    \ contained
    \ keepend

syn region p6PodParaConfigRegion
    \ matchgroup=p6PodConfig
    \ start=""
    \ end="^\ze\([^=]\|=\S\)"
    \ contains=p6PodConfig,p6PodExtraConfigLeader
    \ contained

syn region p6PodPara
    \ start="^[^=]"
    \ end="^\ze\(\s*$\|=\S\)"
    \ contains=@p6PodAmbient
    \ contained
    \ extend

" Special things one may find in Pod prose
syn cluster p6PodAmbient
    \ add=p6PodFormat
    \ add=p6PodVerbatim

" These may appear inside delimited blocks
syn cluster p6PodNested
    \ add=p6PodAbbrRegion
    \ add=p6PodDirectRegion
    \ add=p6PodDelimRegion
    \ add=p6PodParaRegion

" Pod formatting codes
syn region p6PodFormat
    \ start="\u<[^<]"me=e-1
    \ end=">"
    \ contains=p6PodFormat
    \ oneline
    \ contained

syn region p6PodFormat
    \ start="\u«[^«]"me=e-1
    \ end="»"
    \ contains=p6PodFormat
    \ oneline
    \ contained

syn region p6PodFormat
    \ start="\u<<\s"
    \ end="\s>>"
    \ contains=p6PodFormat
    \ oneline
    \ contained

syn match p6PodFormat  "Z<>" contained
syn match p6PodFormat  "E<\(\d\+\|\I\i*\)>" contains=p6PodEscape,p6PodEscape2
syn match p6PodEscape  "\I\i*>"me=e-1       contained
syn match p6PodEscape2 "\d\+>"me=e-1        contained

" Pod Misc
syn match p6PodConfig            ":[^#]*"   contained
syn match p6PodExtraConfigLeader "^="       contained
syn match p6PodVerbatim          "^\s.*"    contained

" Variables, arrays, and hashes with ordinary \w+ names
syn match p6KeyType      "¢[:\.*^?]\?[a-zA-Z_]\w*"
syn match p6VarPlain     "\(::?\|[$@%][\!\.*^?]\?\)[a-zA-Z_]\w*"
syn match p6VarException "\$![a-zA-Z]\@!"
syn match p6VarCapt      "\$[0-9\/]"
syn match p6VarPunct     "\$\d\+"
syn match p6Invoke       "\(&\|[.:]/\)[a-zA-Z_]\w*"

syn cluster p6Interp contains=p6VarPlain,p6InterpExpression,p6VarPunct,p6VarException,p6InterpClosure

" { ... } construct
syn region p6InterpExpression contained matchgroup=p6Variable start=+{+ skip=+\\}+ end=+}+ contains=TOP

" FIXME: This ugly hack will show up later on. Once again, don't try to fix it.
syn region p6ParenExpression start="\(<\s*\)\@<!(" end=")" transparent
syn region p6BracketExpression start="\[" end="]" transparent

" Double-quoted, qq, qw, qx, `` strings
syn region p6InterpString start=+"+ skip=+\\"+ end=+"+ contains=@p6Interp
syn region p6InterpString start=+«+ end=+»+ contains=@p6Interp
syn region p6InterpString start=+<<+ end=+>>+ contains=@p6Interp
" Punctuation-delimited strings
syn region p6InterpString start="\<q[qwx]\(:\(!\?[A-Za-z0-9]\((\w\+)\)\?\)\+\)\?\s*\z([^a-zA-Z0-9:#_ ]\)" skip="\\\z1" end="\z1" contains=@p6Interp
syn region p6InterpString start="\<q[qwx]\(:\(!\?[A-Za-z0-9]\((\w\+)\)\?\)\+\)\?\s*{" skip="\\}" end="}" contains=@p6Interp
syn region p6InterpString start="\<q[qwx]\(:\(!\?[A-Za-z0-9]\((\w\+)\)\?\)\+\)\?\s*(" skip="\\)" end=")" contains=@p6Interp
syn region p6InterpString start="\<q[qwx]\(:\(!\?[A-Za-z0-9]\((\w\+)\)\?\)\+\)\?\s*\[" skip="\\]" end="]" contains=@p6Interp
syn region p6InterpString start="\<q[qwx]\(:\(!\?[A-Za-z0-9]\((\w\+)\)\?\)\+\)\?\s*<" skip="\\>" end=">" contains=@p6Interp

" Single-quoted, q, '' strings
syn region p6LiteralString start=+'+ skip=+\\'+ end=+'+
syn region p6LiteralString start=+<<\@!\(.*>\)\@=+ end=+>\@<!>+
" Punctuation-delimited strings
syn region p6LiteralString start="\<q\(:\(!\?[A-Za-z0-9]\((\w\+)\)\?\)\+\)\?\s*\z([^a-zA-Z0-9:#_ ]\)" skip="\\\z1" end="\z1"
syn region p6LiteralString start="\<q\(:\(!\?[A-Za-z0-9]\((\w\+)\)\?\)\+\)\?\s*{" skip="\\}" end="}"
syn region p6LiteralString start="\<q\(:\(!\?[A-Za-z0-9]\((\w\+)\)\?\)\+\)\?\s*(" skip="\\)" end=")"
syn region p6LiteralString start="\<q\(:\(!\?[A-Za-z0-9]\((\w\+)\)\?\)\+\)\?\s*\[" skip="\\]" end="]"
syn region p6LiteralString start="\<q\(:\(!\?[A-Za-z0-9]\((\w\+)\)\?\)\+\)\?\s*<" skip="\\>" end=">"

" Numbers
syn match  p6Number "\<\(\d*\.\d\+\|\d\+\.\d*\|\d\+\)\(e\d\+\)\{0,1}"
syn match  p6Number "\<0o[0-7]\+"
syn match  p6Number "\<0x[0-9a-fA-F]\+"
syn keyword p6Number NaN Inf

" => Operator
syn match  p6InterpString "\w\+\s*=>"he=e-2
" :key<val>
syn match  p6InterpString ":\w\+\(\s*\.\)\?\(<[^>]*>\)\?"hs=s+1


" Sexeger!
syn cluster p6Regexen contains=@p6Interp,p6Closure,p6Comment,p6CharClass,p6RuleCall,p6TestExpr,p6RegexSpecial

" Here's how we get into regex mode
" Standard /.../
syn region p6Regex matchgroup=p6Keyword start="\(\w\_s*\)\@<!/" start="\(\(\<split\|\<grep\)\s*\)\@<=/" skip="\\/" end="/" contains=@p6Regexen
" m:/.../
syn region p6Regex matchgroup=p6Keyword start="\<\(m\|mm\|rx\)\_s*\(\_s*:\_s*[a-zA-Z0-9_()]\+\)*\_s*\z([^a-zA-Z0-9_:(]\)" skip="\\\z1" end="\z1" contains=@p6Regexen
" m:[] m:{} and m:<>
syn region p6Regex matchgroup=p6Keyword start="\<\(m\|mm\|rx\)\_s*\(\_s*:\_s*[a-zA-Z0-9_()]\+\)*\_s*\[" skip="\\]" end="]" contains=@p6Regexen
syn region p6Regex matchgroup=p6Keyword start="\<\(m\|mm\|rx\)\_s*\(\_s*:\_s*[a-zA-Z0-9_()]\+\)*\_s*{" skip="\\}" end="}" contains=@p6Regexen
syn region p6Regex matchgroup=p6Keyword start="\<\(m\|mm\|rx\)\_s*\(\_s*:\_s*[a-zA-Z0-9_()]\+\)*\_s*<"hs=e skip="\\>" end=">" contains=@p6Regexen


" rule { }
syn region p6Regex start="rule\(\_s\+\w\+\)\{0,1}\_s*{"hs=e end="}" contains=@p6Regexen
"syn region p6Regex start="\(rule\|token\|regex\)\(\_s\+\w\+\)\{0,1}\_s*{"hs=e end="}" contains=@p6Regexen

" Closure (FIXME: Really icky hack, also doesn't support :blah modifiers)
" However, don't do what you might _expect_ would work, because it won't.
" And no variant of it will, either.  I found this out through 4 hours from
" miniscule tweaking to complete redesign.  This is the only way I've found!
syn region p6Closure start="\(\(rule\(\_s\+\w\+\)\{0,1}\|s\|rx\)\_s*\)\@<!{" end="}" matchgroup=p6Error end="[\])]"  contains=TOP   fold
"syn region p6Closure start="\(\(\(rule\|token\|regex\)\(\_s\+\w\+\)\{0,1}\|s\|rx\)\_s*\)\@<!{" end="}" matchgroup=p6Error end="[\])]"  contains=TOP   fold


" s:///, tr:///,  and all variants
syn region p6Regex matchgroup=p6Keyword start="\<s\_s*\(\_s*:\_s*[a-zA-Z0-9_()]\+\)*\_s*\z([^a-zA-Z0-9_:(]\)" skip="\\\z1" end="\z1"me=e-1 nextgroup=p6SubNonBracket contains=@p6Regexen
syn region p6Regex matchgroup=p6KeyWord start="\<s\_s*\(\_s*:\_s*[a-zA-Z0-9_()]\+\)*\_s*\[" skip="\\]" end="]\_s*" nextgroup=p6SubBracket contains=@p6Regexen
syn region p6Regex matchgroup=p6Keyword start="\<s\_s*\(\_s*:\_s*[a-zA-Z0-9_()]\+\)*\_s*{" skip="\\}" end="}\_s*" nextgroup=p6SubBracket contains=@p6Regexen
syn region p6Regex matchgroup=p6Keyword start="\<s\_s*\(\_s*:\_s*[a-zA-Z0-9_()]\+\)*\_s*<" skip="\\>" end=">\_s*" nextgroup=p6SubBracket contains=@p6Regexen
syn region p6Regex matchgroup=p6Keyword start="\<tr\_s*\(\_s*:\_s*[a-zA-Z0-9_()]\+\)*\_s*\z([^a-zA-Z0-9_:(]\)" skip="\\\z1" end="\z1"me=e-1 nextgroup=p6TransNonBracket

" This is kinda tricky. Since these are contained, they're "called" by the
" previous four groups. They just pick up the delimiter at the current location
" and behave like a string.

syn region p6SubNonBracket matchgroup=p6Keyword contained start="\z(\W\)" skip="\\\z1" end="\z1" contains=@p6Interp
syn region p6SubBracket matchgroup=p6Keyword contained start="\z(\W\)" skip="\\\z1" end="\z1" contains=@p6Interp
syn region p6SubBracket matchgroup=p6Keyword contained start="\[" skip="\\]" end="]" contains=@p6Interp
syn region p6SubBracket matchgroup=p6Keyword contained start="{" skip="\\}" end="}" contains=@p6Interp
syn region p6SubBracket matchgroup=p6Keyword contained start="<" skip="\\>" end=">" contains=@p6Interp
syn region p6TransNonBracket matchgroup=p6Keyword contained start="\z(\W\)" skip="\\\z1" end="\z1"


syn match p6RuleCall  contained "<\s*!\{0,1}\s*\w\+"hs=s+1
syn match p6CharClass contained "<\s*!\{0,1}\s*\[\]\{0,1}[^]]*\]\s*>"
syn match p6CharClass contained "<\s*!\{0,1}\s*-\{0,1}\(alpha\|digit\|sp\|ws\|null\|xdigit\|alnum\|space\|ascii\|cntrl\|graph\|lower\|print\|punct\|title\|upper\|word\|vspace\|hspace\)\s*>"
syn match p6CharClass contained "\\[HhVvNnTtEeRrFfWwSs]"
syn match p6CharClass contained "\\[xX]\(\[[0-9a-f;]\+\]\|\x\+\)"
syn match p6CharClass contained "\\0\(\[[0-7;]\+\]\|\o\+\)"
syn region p6CharClass   contained start="\\[QqCc]\[" end="]" skip="\\]"
syn match p6RegexSpecial contained "\\\@<!:\{1,3\}"
syn match p6RegexSpecial contained "<\s*\(cut\|commit\)\s*>"
"syn match p6RegexSpecial contained "\\\@<![+*|]"
syn match p6RegexSpecial contained ":="
syn region p6CharClass   contained start=+<\s*!\{0,1}\s*\z(['"]\)+ skip=+\\\z1+ end=+\z1\s*>+
"syn region p6TestExpr contained start="<\s*!\{0,1}\s*(" end=")\s*>" contains=TOP
syn region p6TestExpr contained start="<\(?\|!\)?{" end="}\s*>" contains=TOP


" Hash quoting (sortof a hack)
" syn match p6InterpString "{\s*\w\+\s*}"ms=s+1,me=e-1

syn match p6Normal "//"

hi link p6Shebang       PreProc
hi link p6Attn          Todo
hi link p6Normal        Normal
hi link p6Regex         String
hi link p6SubNonBracket p6String
hi link p6SubBracket    p6String
hi link p6TransNonBracket p6String
hi link p6CharClass     Special
hi link p6RuleCall      Identifier
hi link p6RegexSpecial  Type

hi link p6Error         Error
hi link p6Module        p6Keyword
hi link p6KeyCompare    p6Keyword
hi link p6KeyDecl       p6Keyword
hi link p6KeyScopeDecl  p6Keyword
hi link p6KeyFlow       p6Keyword
hi link p6ClosureTrait  PreProc
hi link p6KeyException  Special
hi link p6KeyIO         p6Keyword
hi link p6KeyProperty   Type
hi link p6KeyFunc       p6Keyword
hi link p6KeySpecial    Special
hi link p6KeyType       Type

hi link p6Pattern       p6Keyword
hi link p6VarPlain      p6Variable
hi link p6VarPunct      p6Variable
hi link p6VarCapt       p6Variable
hi link p6Invoke        Type
hi link p6InterpString  p6String
hi link p6LiteralString p6String

hi link p6Keyword       Statement
hi link p6Number        Number
hi link p6Comment       Comment
hi link p6Variable      Identifier
hi link p6VarException  Special
hi link p6String        String

hi link p6PodPara              p6Pod
hi link p6PodAbbr              p6Pod
hi link p6PodDelim             p6Pod
hi link p6PodDelimEndRegion    p6PodType
hi link p6PodExtraConfigLeader p6PodCommand

hi link p6Pod          Comment
hi link p6PodCommand   Keyword
hi link p6PodType      Constant
hi link p6PodConfig    Identifier
hi link p6PodFormat    Special
hi link p6PodVerbatim  Special

let b:current_syntax = "perl6"
