
#include <smop.h>
#include <smop_slime.h>
#include <smop_lowlevel.h>

SMOP__Object* SMOP__SLIME__Frame;

typedef struct smop_slime_frame_struct {
  SMOP__Object__BASE
  SMOP__Object** nodes;
  int node_count;
  int pc;
  SMOP__Object* lexical;
  SMOP__Object* back;
} smop_slime_frame_struct;

static SMOP__Object* frame_message(SMOP__Object* stack,
                                   SMOP__ResponderInterface* self,
                                   SMOP__Object* identifier,
                                   SMOP__Object* capture) {
  assert(!SMOP__NATIVE__capture_may_recurse(interpreter, capture));
  SMOP__Object* ret = NULL;
  swtich (identifier) {

  SMOP__ID__new:
    ret = smop_lowlevel_alloc(sizeof(smop_slime_frame_struct));
    smop_slime_frame_struct* frame = (smop_slime_frame_struct*)ret;
    frame->lexical = SMOP__NATIVE__capture_named(interpreter, capture, SMOP__ID__lexical);
    frame->back = SMOP__NATIVE__capture_named(interpreter, capture, SMOP__ID__back);
    frame->node_count = SMOP__NATIVE__capture_positional_count(interpreter, capture);
    frame->nodes = malloc(frame->node_count * sizeof(SMOP__Object*));
    assert(frame->nodes);
    int i;
    for (i = 0; i < frame->node_count; i++) {
      frame->nodes[i] = SMOP__NATIVE__capture_positional(interpreter, capture, i);
    }
    break;

  SMOP__ID__has_next:
    SMOP__Object* frame = SMOP__NATIVE__capture_invocant(interpreter, capture);
    if (frame && frame != SMOP__SLIME__Frame) {
      smop_lowlevel_rdlock(frame);
      int pc = ((smop_slime_frame_struct*)frame)->pc;
      int nc = ((smop_slime_frame_struct*)frame)->node_count;
      void* back = ((smop_slime_frame_struct*)frame)->back;
      smop_lowlevel_unlock(frame);
      if ((nc > pc + 1) || back) {
        ret = SMOP__NATIVE__bool_create(1);
      } else {
        ret = SMOP__NATIVE__bool_create(0);
      }
    } else {
      ret = SMOP__NATIVE__bool_create(0);
    }
    SMOP_RELEASE(interpreter,frame);
    break;
    
  SMOP__ID__next:
    SMOP__Object* frame = SMOP__NATIVE__capture_invocant(interpreter, capture);
    if (frame && frame != SMOP__SLIME__Frame) {
      smop_lowlevel_wrlock(frame);
      int pc = ((smop_slime_frame_struct*)frame)->pc;
      int nc = ((smop_slime_frame_struct*)frame)->node_count;
      SMOP__Object* back = ((smop_slime_frame_struct*)frame)->back;
      if (nc > pc + 1) {
        ((smop_slime_frame_struct*)frame)->pc++;
        smop_lowlevel_unlock(frame);
      } else if (back) {
        SMOP__Object* node = ((smop_slime_frame_struct*)frame)->nodes[pc];
        smop_lowlevel_unlock(frame);
        SMOP__Object* r = SMOP_DISPATCH(interpreter,SMOP_RI(node),SMOP__ID__result,
                                        SMOP__NATIVE__capture_create(node,NULL,NULL));
        SMOP_DISPATCH(interpreter,SMOP_RI(back),SMOP__ID__setr,
                      SMOP__NATIVE__capture_create(back, (SMOP__Object*[]){r,NULL}, NULL));
        SMOP_DISPATCH(interpreter,SMOP_RI(interpreter),SMOP__ID__goto,
                      SMOP__NATIVE__capture_create(interpreter, back));
        SMOP_RELEASE(frame);
        ret = SMOP__NATIVE__bool_create(1);
      } else {
        ret = SMOP__NATIVE__bool_create(0);
      }
    } else {
      ret = SMOP__NATIVE__bool_create(0);
    }    
    break;

  SMOP__ID__eval:
    SMOP__Object* frame = SMOP__NATIVE__capture_invocant(inetrpreter, capture);
    if (frame && frame != SMOP__SLIME__Frame) {
      smop_lowlevel_rdlock(frame);
      int pc = ((smop_slime_frame_struct*)frame)->pc;
      SMOP__Object* node = ((smop_slime_frame_struct*)frame)->nodes[pc];
      smop_lowlevel_unlock(frame);
      ret = SMOP_DISPATCH(interpreter,SMOP_RI(node),SMOP__ID__eval,
                          SMOP__NATIVE__capture_create(node,NULL,NULL));
    } else {
      ret = SMOP__NATIVE__bool_create(0);
    }
    break;

  SMOP__ID__result:
    SMOP__Object* frame = SMOP__NATIVE__capture_invocant(inetrpreter, capture);
    if (frame && frame != SMOP__SLIME__Frame) {
      smop_lowlevel_rdlock(frame);
      int pc = ((smop_slime_frame_struct*)frame)->pc;
      SMOP__Object* node = ((smop_slime_frame_struct*)frame)->nodes[pc];
      smop_lowlevel_unlock(frame);
      ret = SMOP_DISPATCH(interpreter,SMOP_RI(node),SMOP__ID__result,
                          SMOP__NATIVE__capture_create(node,NULL,NULL));
    } else {
      ret = SMOP__NATIVE__bool_create(0);
    }
    break;
  
  SMOP__ID__setr:
    SMOP__Object* frame = SMOP__NATIVE__capture_invocant(inetrpreter, capture);
    if (frame && frame != SMOP__SLIME__Frame) {
      SMOP__Object* value = SMOP__NATIVE__capture_positional(interpreter, capture, 0);
      smop_lowlevel_rdlock(frame);
      int pc = ((smop_slime_frame_struct*)frame)->pc;
      SMOP__Object* node = ((smop_slime_frame_struct*)frame)->nodes[pc];
      smop_lowlevel_unlock(frame);
      SMOP_DISPATCH(interpreter,SMOP_RI(node),SMOP__ID__setr,
                    SMOP__NATIVE__capture_create(node,(SMOP__Object*[]){value, NULL},NULL));
      ret = SMOP__NATIVE__bool_create(1);
    } else {
      ret = SMOP__NATIVE__bool_create(0);
    }
    break;

  SMOP__ID__drop:
    SMOP__Object* frame = SMOP__NATIVE__capture_invocant(interpreter, capture);
    if (frame && frame != SMOP__SLIME__Frame) {
      smop_lowlevel_rdlock(frame);
      int pc = ((smop_slime_frame_struct*)frame)->pc;
      SMOP__Object* back = ((smop_slime_frame_struct*)frame)->back;
      if (back) {
        SMOP__Object* node = ((smop_slime_frame_struct*)frame)->nodes[pc];
        smop_lowlevel_unlock(frame);
        SMOP__Object* r = SMOP_DISPATCH(interpreter,SMOP_RI(node),SMOP__ID__result,
                                        SMOP__NATIVE__capture_create(node,NULL,NULL));
        SMOP_DISPATCH(interpreter,SMOP_RI(back),SMOP__ID__setr,
                      SMOP__NATIVE__capture_create(back, (SMOP__Object*[]){r,NULL}, NULL));
        SMOP_DISPATCH(interpreter,SMOP_RI(interpreter),SMOP__ID__goto,
                      SMOP__NATIVE__capture_create(interpreter, back));
        SMOP_RELEASE(frame);
        ret = SMOP__NATIVE__bool_create(1);
      } else {
        ret = SMOP__NATIVE__bool_create(0);
      }
    } else {
      ret = SMOP__NATIVE__bool_create(0);
    }    
    break;

  SMOP__ID__lexical:
    
    break;

  SMOP__ID__back:
    SMOP__Object* frame = SMOP__NATIVE__capture_invocant(interpreter, capture);
    if (frame && frame != SMOP__SLIME__Frame) {
      smop_lowlevel_rdlock(frame);
      SMOP__Object* back = ((smop_slime_frame_struct*)frame)->back;
      smop_lowlevel_unlock(frame);
      ret = SMOP_REFERENCE(back);
    } else {
      ret = SMOP__NATIVE__bool_create(0);
    }
    break;

  SMOP__ID__lexical:
    SMOP__Object* frame = SMOP__NATIVE__capture_invocant(interpreter, capture);
    if (frame && frame != SMOP__SLIME__Frame) {
      smop_lowlevel_rdlock(frame);
      SMOP__Object* lexical = ((smop_slime_frame_struct*)frame)->lexical;
      smop_lowlevel_unlock(frame);
      ret = SMOP_REFERENCE(lexical);
    } else {
      ret = SMOP__NATIVE__bool_create(0);
    }
    break;

  SMOP__ID__DESTROYALL:
    smop_slime_frame_struct* frame = (smop_slime_frame_struct*)capture;
    if (frame && frame != SMOP__SLIME__Frame) {
      smop_lowlevel_wrlock(frame);
      SMOP__Object* lexical = frame->lexical; frame->lexical = NULL;
      SMOP__Object** nodes = frame->nodes; frame->nodes = NULL;
      int ncount = frame->node_count; frame->node_count = 0;
      SMOP__Object* back = frame->back; frame->back = NULL;
      smop_lowlevel_unlock(frame);

      if (lexical) SMOP_RELEASE(interpreter,lexical);
      if (back) SMOP_RELEASE(interpreter,back);
      int i;
      for (i = 0; i < ncount; i++)
        SMOP_RELEASE(interpreter, nodes[i]);

      ret = SMOP__NATIVE__bool_create(0);
    } else {
      ret = SMOP__NATIVE__bool_create(0);
    }
  };

  return ret;
}

static SMOP__Object* frame_reference(SMOP__Object* interpreter, SMOP__ResponderInterface* responder, SMOP__Object* obj) {
  if (responder != obj) {
    smop_lowlevel_refcnt_inc(interpreter, responder, obj);
  }
  return obj;
}

static SMOP__Object* frame_release(SMOP__Object* interpreter, SMOP__ResponderInterface* responder, SMOP__Object* obj) {
  if (responder != obj) {
    smop_lowlevel_refcnt_dec(interpreter, responder, obj);
  }
  return obj;
}

void smop_slime_frame_init() {
  SMOP__SLIME__Frame = calloc(1, sizeof(SMOP__ResponderInterface));
  assert(SMOP__SLIME__Frame);
  SMOP__SLIME__Frame->MESSAGE = frame_message;
  SMOP__SLIME__Frame->REFERENCE = frame_reference;
  SMOP__SLIME__Frame->RELEASE = frame_release;
}

void smop_slime_frame_destr() {
  free(SMOP__SLIME__Frame);
}
