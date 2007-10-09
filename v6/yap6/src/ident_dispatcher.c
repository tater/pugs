#include "yap6.h"
#include <assert.h>
#include <stdlib.h>

static YAP6__CORE__Value* ident_dispatcher_APPLY(YAP6__CORE__Value* self,
                                          YAP6__CORE__Value* value,
                                          YAP6__CORE__Value* arguments,
                                          YAP6__CORE__Value* wants) {
  return value;
}

static YAP6__CORE__Value* ident_dispatcher_DESTR(YAP6__CORE__Value* self,
                                          YAP6__CORE__Value* value,
                                          YAP6__CORE__Value* arguments,
                                          YAP6__CORE__Value* wants) {
  free(value);
  return NULL;
}

static int ident_dispatcher_COMPR(YAP6__CORE__Value* self,
                                          YAP6__CORE__Value* value,
                                          YAP6__CORE__Value* arguments) {
  if ((int)value < (int)arguments)
    return -1;
  else if ((int)value == (int)arguments)
    return 0;
  else
    return 1;
}

YAP6__CORE__Dispatcher* yap6_const_ident_dispatcher;

void yap6_ident_dispatcher_init() {
  yap6_const_ident_dispatcher = calloc(1,sizeof(YAP6__CORE__Dispatcher));
  assert(yap6_const_ident_dispatcher);
  yap6_const_ident_dispatcher->APPLY = &ident_dispatcher_APPLY;
  yap6_const_ident_dispatcher->DESTR = &ident_dispatcher_DESTR;
  yap6_const_ident_dispatcher->COMPR = &ident_dispatcher_COMPR;
}
