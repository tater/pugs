#include <stdlib.h>
#include <stdio.h>
#include <smop.h>
#include <string.h>
#include <smop_lowlevel.h>
#include <smop_s1p.h>

SMOP__Object* SMOP__Mold;
SMOP__Object* SMOP__Mold__Frame;

static SMOP__Object* SMOP__ID__set_reg;
static SMOP__Object* SMOP__ID__set_back;

static SMOP__Object* mold_reference(SMOP__Object* interpreter, SMOP__ResponderInterface* responder, SMOP__Object* obj) {
  //printf("+ %p\n", obj);
  if ((SMOP__Object*)responder != obj) {
    smop_lowlevel_refcnt_inc(interpreter, responder, obj);
  }
  return obj;
}

static SMOP__Object* mold_release(SMOP__Object* interpreter, SMOP__ResponderInterface* responder, SMOP__Object* obj) {
  //printf("- %p\n", obj);
  if ((SMOP__Object*)responder != obj) {
    smop_lowlevel_refcnt_dec(interpreter, responder, obj);
  }
  return obj;
}


typedef struct smop_mold {
  SMOP__Object__BASE
  int registers;
  SMOP__Object** constants;
  int constants_len;
  int *opcodes;
} smop_mold;

typedef struct smop_mold_frame {
  SMOP__Object__BASE
  SMOP__Object* mold;
  int position;
  SMOP__Object* back;
  SMOP__Object** registers;
  int target;
} smop_mold_frame;

static void print_regs_content(smop_mold_frame* frame) {
    int i;
    smop_mold* mold = (smop_mold*) frame->mold;
    for (i=0;i<mold->registers;i++) {
      if (frame->registers[i]) {
        if (frame->registers[i]->RI) {
          printf("%d:%s\n",i,frame->registers[i]->RI->id);
        } else {
          printf("%d:no RI\n",i);
        }
      } else {
        printf("%d:(null)\n",i);
      }
    }
}

SMOP__Object* mold_back_set(SMOP__Object* interpreter,SMOP__Object* moldframe, SMOP__Object* value) {
    smop_mold_frame* frame = (smop_mold_frame*) moldframe;
    if (frame->back) {
      printf("Cannot redefine mold back!");
      abort();
    }
    frame->back = value;
}

void mold_reg_set(SMOP__Object* interpreter,SMOP__Object* moldframe, int regnum, SMOP__Object* value) {
    smop_mold_frame* frame = (smop_mold_frame*) moldframe;
    smop_mold* mold = (smop_mold*) frame->mold;
    int where = mold->constants_len+regnum;
    SMOP__Object* old = frame->registers[where];
    frame->registers[where] = value;
    if (old) {
      SMOP_RELEASE(interpreter, old);
    }
}

SMOP__Object* SMOP__Mold__Frame_create(SMOP__Object* interpreter,SMOP__Object* mold_object) {
    if (mold_object->RI != (SMOP__ResponderInterface*)SMOP__Mold) {
      fprintf(stderr,"argument to SMOP__Mold__Frame_create is not Mold\n");
    }
    smop_mold* mold = (smop_mold*) mold_object;
    smop_mold_frame* ret = (smop_mold_frame*) smop_lowlevel_alloc(sizeof(smop_mold_frame));
    ret->RI = (SMOP__ResponderInterface*)SMOP__Mold__Frame;
    ret->mold = mold_object;
    ret->position = 0;
    ret->back = NULL;
    ret->registers = (SMOP__Object**) calloc(mold->registers,sizeof(SMOP__ResponderInterface)); 
    ret->target = 0;

    int i;
    for (i = 0; i < mold->constants_len; i++) {
      if (mold->constants[i]) {
        ret->registers[i] = SMOP_REFERENCE(interpreter,mold->constants[i]);
      }
    }


    //printf("Mold Frame! %p\n",ret);
    return (SMOP__Object*) ret;
}

SMOP__Object* SMOP__Mold_create(int registers,SMOP__Object** constants,int opcodes_len,int *opcodes) {
    smop_mold* ret = (smop_mold*) smop_lowlevel_alloc(sizeof(smop_mold));
    ret->RI = (SMOP__ResponderInterface*)SMOP__Mold;

    int i;
    for (i = 0;constants[i];i++);
    i++;

    ret->constants = malloc(sizeof(SMOP__Object*) * i);
    memcpy(ret->constants,constants,sizeof(SMOP__Object*) * i);

    ret->constants_len = i-1;

    ret->registers = registers+i;

    ret->opcodes = malloc(sizeof(int) * opcodes_len);
    memcpy(ret->opcodes,opcodes,sizeof(int) * opcodes_len);

    return (SMOP__Object*) ret;
}

static SMOP__Object* smop_mold_message(SMOP__Object* interpreter,
                                     SMOP__ResponderInterface* self,
                                     SMOP__Object* identifier,
                                     SMOP__Object* capture) {
  ___NATIVE_CAPTURE_ONLY___;
  ___CONST_IDENTIFIER_ONLY___;
  ___INVOCANT_RI_SHOULD_MATCH___;

  smop_mold* mold = (smop_mold*)invocant;
  if (SMOP__ID__DESTROYALL == identifier) {
    int i;
    for (i=0;i <= mold->constants_len;i++) {
      if (mold->constants[i])
        SMOP_RELEASE(interpreter,mold->constants[i]);
    }
    free(mold->constants);
    free(mold->opcodes);
  } else {
    ___UNKNOWN_METHOD___;
  }

  if (invocant) SMOP_RELEASE(interpreter,invocant);
  SMOP_RELEASE(interpreter,capture);
  return SMOP__NATIVE__bool_false;
}

static SMOP__Object* get_register(SMOP__Object* interpreter,smop_mold_frame* frame) {
  smop_mold* mold = (smop_mold*) frame->mold;
  if (!frame->registers[mold->opcodes[frame->position]]) {
    printf("reading empty register %d\n",mold->opcodes[frame->position]);
    abort();
  }
  SMOP__Object* ret = SMOP_REFERENCE(interpreter,frame->registers[mold->opcodes[frame->position]]);
  frame->position++;
  return ret;
}

static SMOP__Object* smop_mold_frame_message(SMOP__Object* interpreter,
                                     SMOP__ResponderInterface* self,
                                     SMOP__Object* identifier,
                                     SMOP__Object* capture) {
  int i; 

  ___NATIVE_CAPTURE_ONLY___;
  ___CONST_IDENTIFIER_ONLY___;
  ___INVOCANT_RI_SHOULD_MATCH___;

  SMOP__Object* ret = SMOP__NATIVE__bool_false;
  smop_mold_frame* frame = (smop_mold_frame*) invocant;
  smop_mold* mold = (smop_mold*) frame->mold;

  if (SMOP__ID__new == identifier) {
    SMOP__Object* mold = SMOP__NATIVE__capture_positional(interpreter, capture, 0);
    ret = SMOP__Mold__Frame_create(interpreter,mold);

  } else if (SMOP__ID__set_reg == identifier) {
    SMOP__Object* reg_pos = SMOP__NATIVE__capture_positional(interpreter, capture, 0);
    SMOP__Object* value = SMOP__NATIVE__capture_positional(interpreter, capture, 1);
    mold_reg_set(interpreter, invocant, SMOP__NATIVE__int_fetch(reg_pos), value);
    SMOP_RELEASE(interpreter,reg_pos);

  } else if (SMOP__ID__back == identifier) {
    if (frame->back) {
      ret = SMOP_REFERENCE(interpreter,frame->back);
    }

  } else if (SMOP__ID__set_back == identifier) {
    SMOP__Object* value = SMOP__NATIVE__capture_positional(interpreter, capture, 0);
    if (!frame->back) {
      frame->back = value;
    } else {
      printf("trying to set a new back to the frame\n");
      abort();
    }

  } else if (SMOP__ID__has_next == identifier) {
    if (mold->opcodes[frame->position]) {
      ret = SMOP__NATIVE__bool_true;
    }

  } else if (SMOP__ID__next == identifier) {

  } else if (SMOP__ID__setr == identifier) {
    SMOP__Object* value = SMOP__NATIVE__capture_positional(interpreter, capture, 0);
    if (!value) {
      printf("got null as a result of a call (reg = %d, pos = %d) via setr\n",frame->target, frame->position);
      abort();
    }

    if (value == invocant) {
      SMOP_RELEASE(interpreter, value);
    }

    if (!frame->target) fprintf(stderr,"calling setr on a frame not expecting a return value\n");
    if (frame->registers[frame->target]) {
      SMOP_RELEASE(interpreter,frame->registers[frame->target]);
    }
    frame->registers[frame->target] = value;

  } else if (SMOP__ID__eval == identifier) {
    int op = mold->opcodes[frame->position];
    if (op) {
      frame->position++;
      ret = SMOP__NATIVE__bool_true;
      switch (op) {
      case 1: { /*call*/
        
        int target = mold->opcodes[frame->position++];
        
        SMOP__Object* call_invocant = get_register(interpreter,frame);

        SMOP__Object* call_identifier = get_register(interpreter,frame);

        int pos_n = mold->opcodes[frame->position++];
        SMOP__Object** call_pos = (SMOP__Object**) malloc((pos_n+1) * sizeof(SMOP__Object*));
        for (i=0;i<pos_n;i++) {
          call_pos[i] = get_register(interpreter,frame);
        }
        call_pos[pos_n] = NULL;

        int named_n = mold->opcodes[frame->position++];
        SMOP__Object** call_named = (SMOP__Object**) malloc((named_n+1) * sizeof(SMOP__Object*));
        for (i=0;i<named_n;i++) {
          call_named[i] = get_register(interpreter,frame);
        }
        call_named[named_n] = NULL;
        SMOP__Object* capture = SMOP__NATIVE__capture_create(interpreter,call_invocant,call_pos,call_named);
        free(call_named);
        free(call_pos);

#ifdef SMOP_MOLD_DEBUG
        if (identifier && SMOP_RI(identifier) == SMOP_RI(SMOP__ID__new)) {
          int u;
          char* external = SMOP__NATIVE__idconst_fetch(call_identifier, &u);
          char* local = malloc(u+1);
          memcpy(local, external, u);
          local[u] = 0;
          fprintf(stderr, "[SMOP_MOLD_DEBUG] eval \"%s\" on \"%s\".\n", local, SMOP_RI(call_invocant)->id);
          free(local);
        } else {
          fprintf(stderr, "[SMOP_MOLD_DEBUG] eval on \"%s\".\n", SMOP_RI(call_invocant)->id);
        }
#endif
        

        SMOP__Object* ret = SMOP_DISPATCH(interpreter,SMOP_RI(call_invocant),call_identifier,capture);
        if (!ret) {
          print_regs_content(frame);
          int identifier_size;
          char *s;
          if (SMOP_RI(call_identifier) == SMOP_RI(SMOP__ID__new)) {
            s = SMOP__NATIVE__idconst_fetch(call_identifier,&identifier_size);
          } else {
            s = "non-constant-identifier";
            identifier_size = strlen(s);
          }
          printf("got NULL as a result of a call (reg = %d, pos=%d, identifier=\"%.*s\")\n",
                 frame->target, frame->position, identifier_size, s);
          abort();
        } else if (ret == invocant) {
          // this circularity is saved by releasing once...
          SMOP_RELEASE(interpreter, ret);
        }

        if (frame->registers[target]) {
          SMOP_RELEASE(interpreter,frame->registers[target]);
        }
        frame->registers[target] = ret;
        frame->target = target;

        break;
      }
      case 2: {/*call2*/
        int target = mold->opcodes[frame->position++];
        SMOP__Object* call_responder  = get_register(interpreter,frame);
        SMOP__Object* call_identifier = get_register(interpreter,frame);
        SMOP__Object* call_capture = get_register(interpreter,frame);

#ifdef SMOP_MOLD_DEBUG
        if (identifier && SMOP_RI(identifier) == SMOP_RI(SMOP__ID__new)) {
          int u;
          char* external = SMOP__NATIVE__idconst_fetch(call_identifier, &u);
          char* local = malloc(u+1);
          memcpy(local, external, u);
          local[u] = 0;
          fprintf(stderr, "[SMOP_MOLD_DEBUG] eval \"%s\" on \"%s\".\n", local, ((SMOP__ResponderInterface*)call_responder)->id);
          free(local);
        } else {
          fprintf(stderr, "[SMOP_MOLD_DEBUG] eval on \"%s\".\n", ((SMOP__ResponderInterface*)call_responder)->id);
        }
#endif

        SMOP__Object* ret = SMOP_DISPATCH(interpreter,SMOP_RI(call_responder),call_identifier,call_capture);
        SMOP_RELEASE(interpreter,call_responder);
        if (frame->registers[target]) {
          SMOP_RELEASE(interpreter,frame->registers[target]);
        }
        frame->registers[target] = ret;
        frame->target = target;
        break;
      }
      case 3: { /*goto*/
        int where = mold->opcodes[frame->position];
        frame->position = where;
        break;
      }

      case 4: {/*br*/
        SMOP__Object* condition = get_register(interpreter,frame);
        int iftrue = mold->opcodes[frame->position++];
        int iffalse = mold->opcodes[frame->position++];
        if (SMOP__NATIVE__bool_true == condition ) {
          frame->position = iftrue;
        } else if (SMOP__NATIVE__bool_false == condition) {
          frame->position = iffalse;
        } else {
          fprintf(stderr,"the condition argument to the br op must be a native bool\n");
          abort();
        }
        break;
      }
      default: fprintf(stderr,"unknown op %d\n",op);
      }
    } else {
      ret = SMOP__NATIVE__bool_false;
    }
  } else if (SMOP__ID__DESTROYALL == identifier) {
    int i;
    for (i=0;i<mold->registers;i++) {
      if (frame->registers[i]) SMOP_RELEASE(interpreter,frame->registers[i]);
      frame->registers[i] = NULL;
    }
    free(frame->registers);
    frame->registers = NULL;
    SMOP_RELEASE(interpreter,frame->mold);
    if (frame->back) SMOP_RELEASE(interpreter,frame->back);
    frame->mold = NULL;
  } else if (identifier == SMOP__ID__FETCH) {
    ___VALUE_FETCH___;

  } else if (identifier == SMOP__ID__STORE) {
    ___VALUE_STORE___;
    
  } else {
    ___UNKNOWN_METHOD___;
  }

  if (invocant) SMOP_RELEASE(interpreter,invocant);
  SMOP_RELEASE(interpreter,capture);
  return ret;
}


void smop_mold_init() {
  SMOP__ID__set_reg = SMOP__NATIVE__idconst_create("set_reg");
  SMOP__ID__set_back = SMOP__NATIVE__idconst_create("set_back");

  SMOP__Mold = calloc(1,sizeof(SMOP__ResponderInterface));
  ((SMOP__ResponderInterface*)SMOP__Mold)->MESSAGE = smop_mold_message;
  ((SMOP__ResponderInterface*)SMOP__Mold)->REFERENCE = smop_lowlevel_generic_reference;
  ((SMOP__ResponderInterface*)SMOP__Mold)->RELEASE = smop_lowlevel_generic_release;
  ((SMOP__ResponderInterface*)SMOP__Mold)->id = "mold";

  SMOP__Mold__Frame = calloc(1,sizeof(SMOP__ResponderInterface));
  ((SMOP__ResponderInterface*)SMOP__Mold__Frame)->MESSAGE = smop_mold_frame_message;
  ((SMOP__ResponderInterface*)SMOP__Mold__Frame)->REFERENCE = mold_reference;
  ((SMOP__ResponderInterface*)SMOP__Mold__Frame)->RELEASE = mold_release;
  ((SMOP__ResponderInterface*)SMOP__Mold__Frame)->id = "mold frame";
}

void smop_mold_destr() {
  free(SMOP__Mold);
  free(SMOP__Mold__Frame);
}

