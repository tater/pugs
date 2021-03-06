#include <stdlib.h>
#include <smop.h>
#include <math.h>
#include <smop_s1p.h>
#include <stdio.h>

SMOP__Object* SMOP__S1P__EndOfIterator;

static SMOP__Object* smop_s1p_endofiterator_message(SMOP__Object* interpreter,
                                                SMOP__ResponderInterface* self,
                                                SMOP__Object* identifier,
                                                SMOP__Object* capture) {
  ___CONST_IDENTIFIER_ONLY___;
  SMOP__Object* ret = SMOP__NATIVE__bool_false;

  if (identifier == SMOP__ID__new) {
    ret = SMOP__S1P__EndOfIterator;

  } else if (identifier == SMOP__ID__defined) {
    ret = SMOP__NATIVE__bool_false;

  } else if (identifier == SMOP__ID__postcircumfix_square) {
    ret = SMOP__NATIVE__bool_false;

  } else if (identifier == SMOP__ID__Iterator) {
    ret = SMOP__S1P__EndOfIterator;

  } else if (identifier == SMOP__ID__List) {
    ret = SMOP__S1P__EndOfIterator;

  } else if (identifier == SMOP__ID__elems) {
    ret = SMOP__NATIVE__int_create(0);

  } else if (identifier == SMOP__ID__DESTROYALL) {

  } else {
      ___UNKNOWN_METHOD___
  }

  SMOP_RELEASE(interpreter,capture);
  return ret;
}

static SMOP__Object* noop(SMOP__Object* interpreter, SMOP__ResponderInterface* responder, SMOP__Object* obj) {
  return obj;
};

void smop_s1p_endofiterator_init() {
  SMOP__S1P__EndOfIterator = calloc(1,sizeof(SMOP__ResponderInterface));
  ((SMOP__ResponderInterface*)SMOP__S1P__EndOfIterator)->MESSAGE = smop_s1p_endofiterator_message;
  ((SMOP__ResponderInterface*)SMOP__S1P__EndOfIterator)->REFERENCE = noop;
  ((SMOP__ResponderInterface*)SMOP__S1P__EndOfIterator)->RELEASE = noop;
  ((SMOP__ResponderInterface*)SMOP__S1P__EndOfIterator)->id = "Lowlevel end of iterator failure";
}

void smop_s1p_endofiterator_destr() {
  free(SMOP__S1P__EndOfIterator);
}


