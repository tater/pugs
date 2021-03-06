#include <stdlib.h>
#include <stdio.h>
#include <smop.h>
#include <string.h>
#include <smop_lowlevel.h>
#include <smop_s1p.h>
#include <smop_mold.h>
#include <smop_oo.h>

SMOP__Object* SMOP__S1P__LexicalPrelude;

void smop_s1p_lexical_prelude_insert(SMOP__Object* interpreter,char* name,SMOP__Object* obj) {
  SMOP_DISPATCH(interpreter,
                SMOP_RI(SMOP__S1P__LexicalPrelude),
                SMOP__ID__bind_key,
                SMOP__NATIVE__capture_create(interpreter,
                                             SMOP_REFERENCE(interpreter,SMOP__S1P__LexicalPrelude),
                                             (SMOP__Object*[]) {SMOP__NATIVE__idconst_create(name),obj,NULL},
                                             NULL));
}
void smop_s1p_lexical_prelude_init() {
  SMOP__Object* interpreter = SMOP__GlobalInterpreter;
  SMOP__S1P__LexicalPrelude = SMOP_DISPATCH(
      interpreter,
      SMOP_RI(SMOP__S1P__LexicalScope),
      SMOP__ID__new,
      SMOP__NATIVE__capture_create(interpreter,SMOP_REFERENCE(interpreter,SMOP__S1P__LexicalScope),NULL,NULL)
  );
  smop_s1p_lexical_prelude_insert(interpreter,"Hash", SMOP__S1P__Hash);
  smop_s1p_lexical_prelude_insert(interpreter,"Array", SMOP__S1P__Array);
  smop_s1p_lexical_prelude_insert(interpreter,"$OUT", SMOP__S1P__IO_create(interpreter));
  smop_s1p_lexical_prelude_insert(interpreter,"Mold", SMOP__Mold);
  smop_s1p_lexical_prelude_insert(interpreter,"MoldFrame", SMOP__Mold__Frame);
  smop_s1p_lexical_prelude_insert(interpreter,"Code", SMOP__S1P__Code);
  smop_s1p_lexical_prelude_insert(interpreter,"Package", SMOP__S1P__Package);
  smop_s1p_lexical_prelude_insert(interpreter,"AdhocSignature", SMOP__S1P__AdhocSignature);
  smop_s1p_lexical_prelude_insert(interpreter,"Scalar", SMOP__S1P__Scalar);
  smop_s1p_lexical_prelude_insert(interpreter,"MoldFrame", SMOP__Mold__Frame);
  smop_s1p_lexical_prelude_insert(interpreter,"p6opaque",SMOP__p6opaque__RI);
  smop_s1p_lexical_prelude_insert(interpreter,"PurePrototypeHow",SMOP_REFERENCE(interpreter,SMOP__S1P__PurePrototypeHow));
}

void smop_s1p_lexical_prelude_destr() {
  SMOP_RELEASE(SMOP__GlobalInterpreter,SMOP__S1P__LexicalPrelude);
}


