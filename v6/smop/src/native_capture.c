#include <smop.h>
#include <smop_lowlevel.h>

/* The native capture prototype is at the same time a responder
 * interface. And the prototype is not subject to garbage
 * collection. Each capture instance, however uses the smop_lowlevel,
 * and, therefore, is subject to gc.
 */
SMOP__Object* SMOP__NATIVE__capture;

typedef struct named_argument {
  SMOP__Object* key;
  SMOP__Object* value;
} named_argument;

typedef struct native_capture_struct {
  SMOP__Object__BASE
  SMOP__Object* invocant;
  SMOP__Object** positional;
  int count_positional;
  /* The keys that are constant identifiers can have an optimized
   * lookup process.
   */
  named_argument* o_named;
  int count_o_named;
  /* Any other object will go to the normal lookup.
   */
  named_argument* named;
  int count_named;
} native_capture_struct;

/* A constant empty capture will be created. Understanding that a
 * capture is readonly, everytime someone tryies to create one using
 * "new", the constant empty capture will be returned.
 */
static SMOP__Object* smop_native_empty_capture;

static SMOP__Object* capture_message(SMOP__Object* stack,
                                     SMOP__ResponderInterface* self,
                                     SMOP__Object* identifier,
                                     SMOP__Object* capture) {
  SMOP__Object* ret = NULL;
  swtich (identifier) {
  SMOP__ID__new:
    ret = smop_native_empty_capture;
    break;
  }
  return ret;
}

static SMOP__Object* capture_reference(SMOP__Object* interpreter, SMOP__ResponderInterface* responder, SMOP__Object* obj) {
  if (responder != obj && smop_native_empty_capture != obj) {
    smop_lowlevel_refcnt_inc(interpreter, responder, obj);
  }
  return obj;
}

static SMOP__Object* capture_release(SMOP__Object* interpreter, SMOP__ResponderInterface* responder, SMOP__Object* obj) {
  if (responder != obj && smop_native_empty_capture != obj) {
    smop_lowlevel_refcnt_dec(interpreter, responder, obj);
  }
  return obj;
}



void smop_native_capture_init() {

  // initialize the capture prototype
  SMOP__NATIVE__capture = calloc(1, sizeof(SMOP__ResponderInterface));
  assert(SMOP__NATIVE__capture);
  SMOP__NATIVE__capture->MESSAGE = capture_message;
  SMOP__NATIVE__capture->REFERENCE = capture_reference;
  SMOP__NATIVE__capture->RELEASE = capture_release;

  smop_native_empty_capture = calloc(1, sizeof(native_capture_struct));
  assert(smop_native_empty_capture);
  smop_native_empty_capture->RI = SMOP__NATIVE__capture;

}

void smop_native_capture_destr() {

  // destroy the capture prototype
  free(smop_native_empty_capture);
  free(SMOP__NATIVE__capture);
 
}

static int cmp_opt_named(const void* p1, const void* p2) {
  if (!p1 && !p2) {
    return 0;
  } else if (p1 && !p2) {
    return -1;
  } else if (!p1 && p2) {
    return 1;
  } else {
    named_argument* n1 = (named_argument*)p1;
    named_argument* n2 = (named_argument*)p2;
    if (n1->key > n2->key) {
      return -1;
    } else if (n2->key > n1->key) {
      return 1;
    } else {
      return 0;
    }
  }
}

SMOP__Object*   SMOP__NATIVE__capture_create(SMOP__Object* interpreter,
                                             SMOP__Object* invocant,
                                             SMOP__Object** positional,
                                             SMOP__Object** named) {

  if (invocant == NULL && positional == NULL && named == NULL)
    return smop_native_empty_capture;

  native_capture_struct* ret = (native_capture_struct*)smop_lowlevel_alloc(sizeof(native_capture_struct));
  
  ret->invocant = invocant;

  if (positional) {
    int length = -1;
    while (positional[++length]);
    int size = sizeof(SMOP__Object*) * length;
    ret->positional = malloc(size);
    memcpy(ret->positional, positional, size);
    ret->count_positional = length - 1;
  }

  if (named) {
     int length = 0;
    int l_opt = 0;
    int l_nor = 0;
    while (named[length]) {
      if (named[length]->RI == SMOP__ID__new->RI) {
        l_opt++;
      } else {
        l_nor++;
      }
      length += 2;
    }

    int s_opt = sizeof(named_argument) * (l_opt + 1);
    ret->o_named = malloc(s_opt);
    ret->o_named[l_opt] = NULL;
    ret->count_o_named = l_opt;
    int s_nor = sizeof(named_argument) * (l_nor + 1);
    ret->named = malloc(s_nor);
    ret->named[l_nor] = NULL;
    ret->count_named = l_nor;

    length = 0;
    l_opt = 0;
    l_nor = 0;
    while (named[length]) {
      if (named[length]->RI == SMOP__ID__new->RI) {
        ret->o_named[l_opt]->key = named[length];
        ret->o_named[l_opt]->value = named[length + 1];
        l_opt++;
      } else {
        ret->named[l_nor]->key = named[length];
        ret->named[l_nor]->value = named[length + 1];
        l_nor++;
      }
      length += 2;
    }

    /* To optimize lookup, let's sort the named arguments in order to
     * be able to do binary searchs later.
     */
    if (l_opt) {
      qsort(ret->named, l_opt, sizeof(named_argument), cmp_opt_named);
    }

    /* The same would apply here, but we still don't have the string
     * code to call WHICH.
     */
    if (l_nor) {
      fprintf(sdterr, "Native capture still don't support non-constant-identifiers as key for named arguments.\n");
    }
    
  }
  
  return ret;
}

SMOP__Object*   SMOP__NATIVE__capture_invocant(SMOP__Object* interpreter,
                                               SMOP__Object* capture) {
  // TODO: locking
  if (capture) {
    return SMOP_REFERENCE(interpreter, ((native_capture_struct*)capture)->invocant);
  } else {
    return NULL;
  }
}

SMOP__Object*   SMOP__NATIVE__capture_positional(SMOP__Object* interpreter,
                                                 SMOP__Object* capture, int p) {
  // TODO: locking.
  if (capture) {
    native_capture_struct* self = ((native_capture_struct*)capture);
    if (p > self->count_positional) {
      return NULL;
    } else {
      return SMOP_REFERENCE(interpreter, self->positional[p]);
    }
  } else {
    return NULL;
  }
}

SMOP__Object*   SMOP__NATIVE__capture_named(SMOP__Object* interpreter,
                                            SMOP__Object* capture,
                                            SMOP__Object* identifier) {

}
