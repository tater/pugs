#!/usr/bin/env six
# WARNING - this file is mechanically generated.  Your changes will be overwritten.
# Usage: --help

class Strscan {
  # ...
}

class Tempfile {
  # ...
}


class Scrape {
  has $.scanner;
  has $.string;    
  # ...
}

class BuildIR {
  # ...
}

  class IR0::Base {
  }
  class IR0::Val_Base is Base {
  }
  class IR0::Lit_Base is Base {
  }
  class IR0::Rule_Base is Base {
  }

  class IR0::PackageDeclarator is Base {
    has $.kind;
    has $.name;
    has $.block;
    
    method new($kind,$name,$block) {
      $.kind = $kind;
      $.name = $name;
      $.block = $block;
      
    }
    method emit($emitter) { $emitter.emit_PackageDeclarator(self) }
  }
  class IR0::Block is Base {
    has $.statements;
    
    method new($statements) {
      $.statements = $statements;
      
    }
    method emit($emitter) { $emitter.emit_Block(self) }
  }
  class IR0::Quote is Base {
    has $.concat;
    
    method new($concat) {
      $.concat = $concat;
      
    }
    method emit($emitter) { $emitter.emit_Quote(self) }
  }
  class IR0::CompUnit is Base {
    has $.unit_type;
    has $.name;
    has $.traits;
    has $.attributes;
    has $.methods;
    has $.body;
    
    method new($unit_type,$name,$traits,$attributes,$methods,$body) {
      $.unit_type = $unit_type;
      $.name = $name;
      $.traits = $traits;
      $.attributes = $attributes;
      $.methods = $methods;
      $.body = $body;
      
    }
    method emit($emitter) { $emitter.emit_CompUnit(self) }
  }
  class IR0::Val_Int is Val_Base {
    has $.int;
    
    method new($int) {
      $.int = $int;
      
    }
    method emit($emitter) { $emitter.emit_Val_Int(self) }
  }
  class IR0::Val_Bit is Val_Base {
    has $.bit;
    
    method new($bit) {
      $.bit = $bit;
      
    }
    method emit($emitter) { $emitter.emit_Val_Bit(self) }
  }
  class IR0::Val_Num is Val_Base {
    has $.num;
    
    method new($num) {
      $.num = $num;
      
    }
    method emit($emitter) { $emitter.emit_Val_Num(self) }
  }
  class IR0::Val_Buf is Val_Base {
    has $.buf;
    
    method new($buf) {
      $.buf = $buf;
      
    }
    method emit($emitter) { $emitter.emit_Val_Buf(self) }
  }
  class IR0::Val_Char is Val_Base {
    has $.char;
    
    method new($char) {
      $.char = $char;
      
    }
    method emit($emitter) { $emitter.emit_Val_Char(self) }
  }
  class IR0::Val_Undef is Val_Base {
    
    method new() {
      
    }
    method emit($emitter) { $emitter.emit_Val_Undef(self) }
  }
  class IR0::Val_Object is Val_Base {
    has $.clazz;
    has $.fields;
    
    method new($clazz,$fields) {
      $.clazz = $clazz;
      $.fields = $fields;
      
    }
    method emit($emitter) { $emitter.emit_Val_Object(self) }
  }
  class IR0::Lit_Seq is Lit_Base {
    has $.seq;
    
    method new($seq) {
      $.seq = $seq;
      
    }
    method emit($emitter) { $emitter.emit_Lit_Seq(self) }
  }
  class IR0::Lit_Array is Lit_Base {
    has $.array;
    
    method new($array) {
      $.array = $array;
      
    }
    method emit($emitter) { $emitter.emit_Lit_Array(self) }
  }
  class IR0::Lit_Hash is Lit_Base {
    has $.hash;
    
    method new($hash) {
      $.hash = $hash;
      
    }
    method emit($emitter) { $emitter.emit_Lit_Hash(self) }
  }
  class IR0::Lit_Pair is Lit_Base {
    has $.key;
    has $.value;
    
    method new($key,$value) {
      $.key = $key;
      $.value = $value;
      
    }
    method emit($emitter) { $emitter.emit_Lit_Pair(self) }
  }
  class IR0::Lit_SigArgument is Lit_Base {
    has $.key;
    has $.value;
    has $.type;
    has $.has_default;
    has $.is_named_only;
    has $.is_optional;
    has $.is_slurpy;
    has $.is_multidimensional;
    has $.is_rw;
    has $.is_copy;
    
    method new($key,$value,$type,$has_default,$is_named_only,$is_optional,$is_slurpy,$is_multidimensional,$is_rw,$is_copy) {
      $.key = $key;
      $.value = $value;
      $.type = $type;
      $.has_default = $has_default;
      $.is_named_only = $is_named_only;
      $.is_optional = $is_optional;
      $.is_slurpy = $is_slurpy;
      $.is_multidimensional = $is_multidimensional;
      $.is_rw = $is_rw;
      $.is_copy = $is_copy;
      
    }
    method emit($emitter) { $emitter.emit_Lit_SigArgument(self) }
  }
  class IR0::Lit_NamedArgument is Lit_Base {
    has $.key;
    has $.value;
    
    method new($key,$value) {
      $.key = $key;
      $.value = $value;
      
    }
    method emit($emitter) { $emitter.emit_Lit_NamedArgument(self) }
  }
  class IR0::Lit_Code is Lit_Base {
    has $.pad;
    has $.state;
    has $.sig;
    has $.body;
    has $.catch;
    
    method new($pad,$state,$sig,$body,$catch) {
      $.pad = $pad;
      $.state = $state;
      $.sig = $sig;
      $.body = $body;
      $.catch = $catch;
      
    }
    method emit($emitter) { $emitter.emit_Lit_Code(self) }
  }
  class IR0::Lit_Object is Lit_Base {
    has $.clazz;
    has $.fields;
    
    method new($clazz,$fields) {
      $.clazz = $clazz;
      $.fields = $fields;
      
    }
    method emit($emitter) { $emitter.emit_Lit_Object(self) }
  }
  class IR0::Var is Base {
    has $.sigil;
    has $.twigil;
    has $.name;
    has $.namespace;
    
    method new($sigil,$twigil,$name,$namespace) {
      $.sigil = $sigil;
      $.twigil = $twigil;
      $.name = $name;
      $.namespace = $namespace;
      
    }
    method emit($emitter) { $emitter.emit_Var(self) }
  }
  class IR0::Bind is Base {
    has $.parameters;
    has $.arguments;
    
    method new($parameters,$arguments) {
      $.parameters = $parameters;
      $.arguments = $arguments;
      
    }
    method emit($emitter) { $emitter.emit_Bind(self) }
  }
  class IR0::Assign is Base {
    has $.parameters;
    has $.arguments;
    
    method new($parameters,$arguments) {
      $.parameters = $parameters;
      $.arguments = $arguments;
      
    }
    method emit($emitter) { $emitter.emit_Assign(self) }
  }
  class IR0::Proto is Base {
    has $.name;
    
    method new($name) {
      $.name = $name;
      
    }
    method emit($emitter) { $emitter.emit_Proto(self) }
  }
  class IR0::Call is Base {
    has $.invocant;
    has $.hyper;
    has $.method;
    has $.arguments;
    
    method new($invocant,$hyper,$method,$arguments) {
      $.invocant = $invocant;
      $.hyper = $hyper;
      $.method = $method;
      $.arguments = $arguments;
      
    }
    method emit($emitter) { $emitter.emit_Call(self) }
  }
  class IR0::Apply is Base {
    has $.code;
    has $.arguments;
    
    method new($code,$arguments) {
      $.code = $code;
      $.arguments = $arguments;
      
    }
    method emit($emitter) { $emitter.emit_Apply(self) }
  }
  class IR0::Return is Base {
    has $.result;
    
    method new($result) {
      $.result = $result;
      
    }
    method emit($emitter) { $emitter.emit_Return(self) }
  }
  class IR0::If is Base {
    has $.cond;
    has $.body;
    has $.otherwise;
    
    method new($cond,$body,$otherwise) {
      $.cond = $cond;
      $.body = $body;
      $.otherwise = $otherwise;
      
    }
    method emit($emitter) { $emitter.emit_If(self) }
  }
  class IR0::While is Base {
    has $.cond;
    has $.body;
    
    method new($cond,$body) {
      $.cond = $cond;
      $.body = $body;
      
    }
    method emit($emitter) { $emitter.emit_While(self) }
  }
  class IR0::Decl is Base {
    has $.decl;
    has $.type;
    has $.var;
    
    method new($decl,$type,$var) {
      $.decl = $decl;
      $.type = $type;
      $.var = $var;
      
    }
    method emit($emitter) { $emitter.emit_Decl(self) }
  }
  class IR0::Sig is Base {
    has $.invocant;
    has $.positional;
    
    method new($invocant,$positional) {
      $.invocant = $invocant;
      $.positional = $positional;
      
    }
    method emit($emitter) { $emitter.emit_Sig(self) }
  }
  class IR0::Lit_Capture is Lit_Base {
    has $.invocant;
    has $.array;
    has $.hash;
    
    method new($invocant,$array,$hash) {
      $.invocant = $invocant;
      $.array = $array;
      $.hash = $hash;
      
    }
    method emit($emitter) { $emitter.emit_Lit_Capture(self) }
  }
  class IR0::Lit_Subset is Lit_Base {
    has $.name;
    has $.base_class;
    has $.block;
    
    method new($name,$base_class,$block) {
      $.name = $name;
      $.base_class = $base_class;
      $.block = $block;
      
    }
    method emit($emitter) { $emitter.emit_Lit_Subset(self) }
  }
  class IR0::Method is Base {
    has $.name;
    has $.sig;
    has $.block;
    
    method new($name,$sig,$block) {
      $.name = $name;
      $.sig = $sig;
      $.block = $block;
      
    }
    method emit($emitter) { $emitter.emit_Method(self) }
  }
  class IR0::Sub is Base {
    has $.name;
    has $.sig;
    has $.block;
    
    method new($name,$sig,$block) {
      $.name = $name;
      $.sig = $sig;
      $.block = $block;
      
    }
    method emit($emitter) { $emitter.emit_Sub(self) }
  }
  class IR0::Macro is Base {
    has $.name;
    has $.sig;
    has $.block;
    
    method new($name,$sig,$block) {
      $.name = $name;
      $.sig = $sig;
      $.block = $block;
      
    }
    method emit($emitter) { $emitter.emit_Macro(self) }
  }
  class IR0::Coro is Base {
    has $.name;
    has $.sig;
    has $.block;
    
    method new($name,$sig,$block) {
      $.name = $name;
      $.sig = $sig;
      $.block = $block;
      
    }
    method emit($emitter) { $emitter.emit_Coro(self) }
  }
  class IR0::P5Token is Base {
    has $.regex;
    
    method new($regex) {
      $.regex = $regex;
      
    }
    method emit($emitter) { $emitter.emit_P5Token(self) }
  }
  class IR0::Token is Base {
    has $.name;
    has $.regex;
    has $.sym;
    
    method new($name,$regex,$sym) {
      $.name = $name;
      $.regex = $regex;
      $.sym = $sym;
      
    }
    method emit($emitter) { $emitter.emit_Token(self) }
  }
  class IR0::Do is Base {
    has $.block;
    
    method new($block) {
      $.block = $block;
      
    }
    method emit($emitter) { $emitter.emit_Do(self) }
  }
  class IR0::Begin is Base {
    has $.block;
    
    method new($block) {
      $.block = $block;
      
    }
    method emit($emitter) { $emitter.emit_Begin(self) }
  }
  class IR0::Use is Base {
    has $.mod;
    has $.perl5;
    
    method new($mod,$perl5) {
      $.mod = $mod;
      $.perl5 = $perl5;
      
    }
    method emit($emitter) { $emitter.emit_Use(self) }
  }
  class IR0::Rule is Base {
    
    method new() {
      
    }
    method emit($emitter) { $emitter.emit_Rule(self) }
  }
  class IR0::Rule_Quantifier is Rule_Base {
    has $.term;
    has $.quant;
    has $.greedy;
    has $.ws1;
    has $.ws2;
    has $.ws3;
    
    method new($term,$quant,$greedy,$ws1,$ws2,$ws3) {
      $.term = $term;
      $.quant = $quant;
      $.greedy = $greedy;
      $.ws1 = $ws1;
      $.ws2 = $ws2;
      $.ws3 = $ws3;
      
    }
    method emit($emitter) { $emitter.emit_Rule_Quantifier(self) }
  }
  class IR0::Rule_Or is Rule_Base {
    has $.terms;
    
    method new($terms) {
      $.terms = $terms;
      
    }
    method emit($emitter) { $emitter.emit_Rule_Or(self) }
  }
  class IR0::Rule_Concat is Rule_Base {
    has $.concat;
    
    method new($concat) {
      $.concat = $concat;
      
    }
    method emit($emitter) { $emitter.emit_Rule_Concat(self) }
  }
  class IR0::Rule_Subrule is Rule_Base {
    has $.metasyntax;
    has $.ident;
    has $.capture_to_array;
    
    method new($metasyntax,$ident,$capture_to_array) {
      $.metasyntax = $metasyntax;
      $.ident = $ident;
      $.capture_to_array = $capture_to_array;
      
    }
    method emit($emitter) { $emitter.emit_Rule_Subrule(self) }
  }
  class IR0::Rule_SubruleNoCapture is Rule_Base {
    has $.metasyntax;
    
    method new($metasyntax) {
      $.metasyntax = $metasyntax;
      
    }
    method emit($emitter) { $emitter.emit_Rule_SubruleNoCapture(self) }
  }
  class IR0::Rule_Var is Rule_Base {
    has $.sigil;
    has $.twigil;
    has $.name;
    
    method new($sigil,$twigil,$name) {
      $.sigil = $sigil;
      $.twigil = $twigil;
      $.name = $name;
      
    }
    method emit($emitter) { $emitter.emit_Rule_Var(self) }
  }
  class IR0::Rule_Constant is Rule_Base {
    has $.constant;
    
    method new($constant) {
      $.constant = $constant;
      
    }
    method emit($emitter) { $emitter.emit_Rule_Constant(self) }
  }
  class IR0::Rule_Dot is Rule_Base {
    
    method new() {
      
    }
    method emit($emitter) { $emitter.emit_Rule_Dot(self) }
  }
  class IR0::Rule_SpecialChar is Rule_Base {
    has $.char;
    
    method new($char) {
      $.char = $char;
      
    }
    method emit($emitter) { $emitter.emit_Rule_SpecialChar(self) }
  }
  class IR0::Rule_Block is Rule_Base {
    has $.closure;
    
    method new($closure) {
      $.closure = $closure;
      
    }
    method emit($emitter) { $emitter.emit_Rule_Block(self) }
  }
  class IR0::Rule_InterpolateVar is Rule_Base {
    has $.var;
    
    method new($var) {
      $.var = $var;
      
    }
    method emit($emitter) { $emitter.emit_Rule_InterpolateVar(self) }
  }
  class IR0::Rule_NamedCapture is Rule_Base {
    has $.rule;
    has $.ident;
    has $.capture_to_array;
    
    method new($rule,$ident,$capture_to_array) {
      $.rule = $rule;
      $.ident = $ident;
      $.capture_to_array = $capture_to_array;
      
    }
    method emit($emitter) { $emitter.emit_Rule_NamedCapture(self) }
  }
  class IR0::Rule_Before is Rule_Base {
    has $.rule;
    has $.assertion_modifier;
    has $.capture_to_array;
    
    method new($rule,$assertion_modifier,$capture_to_array) {
      $.rule = $rule;
      $.assertion_modifier = $assertion_modifier;
      $.capture_to_array = $capture_to_array;
      
    }
    method emit($emitter) { $emitter.emit_Rule_Before(self) }
  }
  class IR0::Rule_After is Rule_Base {
    has $.rule;
    has $.assertion_modifier;
    has $.capture_to_array;
    
    method new($rule,$assertion_modifier,$capture_to_array) {
      $.rule = $rule;
      $.assertion_modifier = $assertion_modifier;
      $.capture_to_array = $capture_to_array;
      
    }
    method emit($emitter) { $emitter.emit_Rule_After(self) }
  }
  class IR0::Rule_NegateCharClass is Rule_Base {
    has $.chars;
    
    method new($chars) {
      $.chars = $chars;
      
    }
    method emit($emitter) { $emitter.emit_Rule_NegateCharClass(self) }
  }
  class IR0::Rule_CharClass is Rule_Base {
    has $.chars;
    
    method new($chars) {
      $.chars = $chars;
      
    }
    method emit($emitter) { $emitter.emit_Rule_CharClass(self) }
  }
  class IR0::Rule_Capture is Rule_Base {
    has $.rule;
    has $.position;
    has $.capture_to_array;
    
    method new($rule,$position,$capture_to_array) {
      $.rule = $rule;
      $.position = $position;
      $.capture_to_array = $capture_to_array;
      
    }
    method emit($emitter) { $emitter.emit_Rule_Capture(self) }
  }

# Constructors
#...
class EmitSimpleP5 {
  #...
}
    
class Program {
  #...
}
Program.new().main(%ARGV)