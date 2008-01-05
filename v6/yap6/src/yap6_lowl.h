#ifndef __YAP6_LOWL_H
#define __YAP6_LOWL_H



/* These are the core runtime routines of YAP6
 */
extern void yap6_init();
extern void yap6_destr();
extern void yap6_memory_init();
extern void yap6_memory_destr();
/* This function is the place from where every allocation should
   happen. For now, it just mallocs with zeros, set refcnt to 1 and
   initialize the rwlock. But it is subject to change, so, keep
   calling it. */
extern YAP6__CORE__Value* yap6_value_alloc(int size);
/* This function increments the reference count of a value, it
   should be called whenever the value is referenced by another
   value */
extern YAP6__CORE__Value* yap6_value_refcnt_inc(YAP6__CORE__Value* value);
/* This functions decrements the reference count of a value, it should
   be called whenever one reference to this value is destroied. It
   will call DESTR in the dispatcher and free() the pointer when
   appropriate. */
extern YAP6__CORE__Value* yap6_value_refcnt_dec(YAP6__CORE__Value* value);
/* This functions synchronizes the access to this value. It should be
   called whenever some pointer in the low-level details (some
   non-core-value member of the struct) will be accessed. */
extern void yap6_value_rdlock(YAP6__CORE__Value* value);
extern void yap6_value_wrlock(YAP6__CORE__Value* value);
extern void yap6_value_unlock(YAP6__CORE__Value* value);


struct YAP6__CORE__string; typedef struct YAP6__CORE__string YAP6__CORE__string;
struct YAP6__CORE__num; typedef struct YAP6__CORE__num YAP6__CORE__num;
struct YAP6__CORE__int; typedef struct YAP6__CORE__int YAP6__CORE__int;
struct YAP6__CORE__bytes; typedef struct YAP6__CORE__bytes YAP6__CORE__bytes;
struct YAP6__CORE__Scalar; typedef struct YAP6__CORE__Scalar YAP6__CORE__Scalar;
struct YAP6__CORE__List; typedef struct YAP6__CORE__List YAP6__CORE__List;
struct YAP6__CORE__Pair; typedef struct YAP6__CORE__Pair YAP6__CORE__Pair;
struct YAP6__CORE__Hash; typedef struct YAP6__CORE__Hash YAP6__CORE__Hash;
struct YAP6__CORE__Capture; typedef struct YAP6__CORE__Capture YAP6__CORE__Capture;
struct YAP6__CORE__ScalarDispatcher; typedef struct YAP6__CORE__ScalarDispatcher YAP6__CORE__ScalarDispatcher;
struct YAP6__CORE__ListDispatcher; typedef struct YAP6__CORE__ListDispatcher YAP6__CORE__ListDispatcher;
struct YAP6__CORE__PairDispatcher; typedef struct YAP6__CORE__PairDispatcher YAP6__CORE__PairDispatcher;
struct YAP6__CORE__HashDispatcher; typedef struct YAP6__CORE__HashDispatcher YAP6__CORE__HashDispatcher;
struct YAP6__CORE__CaptureDispatcher; typedef struct YAP6__CORE__CaptureDispatcher YAP6__CORE__CaptureDispatcher;

// ident_dispatcher
extern YAP6__CORE__Dispatcher* yap6_const_ident_dispatcher;
extern void yap6_ident_dispatcher_init();
extern void yap6_ident_dispatcher_which_init();
extern void yap6_ident_dispatcher_destr();

// const values
extern YAP6__CORE__Value* yap6_const_undef;
extern YAP6__CORE__Value* yap6_bool_false;
extern void yap6_const_init();
extern void yap6_const_destr();



#define YAP6__BASE__LOWL_Dispatcher                                   \
  YAP6__CORE__Value* (*CREATE)(YAP6__CORE__Dispatcher* self,          \
                               YAP6__CORE__List* arguments);          \
  void               (*DESTR)(YAP6__CORE__Dispatcher* self,           \
                               YAP6__CORE__Value* value);             \
  YAP6__CORE__string* (*STRNG)(YAP6__CORE__Dispatcher* self,          \
                               YAP6__CORE__Value* value);             \
  YAP6__CORE__num*   (*NUMBR)(YAP6__CORE__Dispatcher* self,           \
                               YAP6__CORE__Value* value);             \
  YAP6__CORE__Value* (*BOOLN)(YAP6__CORE__Dispatcher* self,           \
                               YAP6__CORE__Value* value);             \
  YAP6__CORE__Scalar* (*SCALAR)(YAP6__CORE__Dispatcher* self,         \
                               YAP6__CORE__Value* value);             \
  YAP6__CORE__List*  (*LIST) (YAP6__CORE__Dispatcher* self,           \
                               YAP6__CORE__Value* value);             \
  YAP6__CORE__Hash*  (*HASH) (YAP6__CORE__Dispatcher* self,           \
                               YAP6__CORE__Value* value);             \
  YAP6__CORE__bytes* (*WHICH)(YAP6__CORE__Dispatcher* self,           \
                               YAP6__CORE__Value* value);

struct YAP6__LOWL__Dispatcher {
  YAP6__BASE__Value
  YAP6__CORE__Dispatcher* dispatcher;
  YAP6__LOWL__Dispacher
}

/* int support */
struct YAP6__CORE__int {
  YAP6__BASE__Value
  YAP6__CORE__Dispatcher* dispatcher;
  int value;  
};

extern YAP6__CORE__Dispatcher* yap6_const_int_dispatcher;
extern void yap6_int_dispatcher_init();
extern void yap6_int_dispatcher_which_init();
extern YAP6__CORE__int* yap6_int_create(int initialvalue);
extern int yap6_int_lowlevel(YAP6__CORE__int* value);
extern void yap6_int_dispatcher_destr();

/* bytes support */
struct YAP6__CORE__bytes {
  YAP6__BASE__Value
  YAP6__CORE__Dispatcher* dispatcher;
  char* value;
  int size;
};

extern YAP6__CORE__Dispatcher* yap6_const_bytes_dispatcher;
extern void yap6_bytes_dispatcher_init();
extern YAP6__CORE__bytes* yap6_bytes_create(const char* initialvalue, int size);
extern char* yap6_bytes_lowlevel(YAP6__CORE__bytes* value, int* sizeret);
extern void yap6_bytes_dispatcher_destr();

struct YAP6__CORE__double {
  YAP6__BASE__Value
  YAP6__CORE__Dispatcher* dispatcher;
  double value;  
} YAP6__CORE__double;

struct YAP6__CORE__num {
  YAP6__BASE__Value
  YAP6__CORE__Dispatcher* dispatcher;
  enum { YAP6__CORE__num__INT, YAP6__CORE__num__DOUBLE,
         YAP6__CORE__num__BIGNUM } precision;
  int int_value;
  double double_value;
  char** bignum_value;
};

struct YAP6__CORE__string {
  YAP6__BASE__Value
  YAP6__CORE__Dispatcher* dispatcher;
  char encoding[16];
  int byte_length;
  char content[];
};

/*
 * The YAP6__CORE__Scalar is a type of object that contains other
 * object inside it.
 */
struct YAP6__CORE__Scalar {
  YAP6__BASE__Value
  YAP6__CORE__ScalarDispatcher* dispatcher;
  YAP6__CORE__Value* cell;
};

/* scalar support */
/*
 * The YAP6__CORE__ScalarDispatcher also implements the FETCH and
 * STORE methods.
 */
struct YAP6__CORE__ScalarDispatcher {
  YAP6__BASE__Value
  YAP6__CORE__Dispatcher* dispatcher;
  YAP6__BASE__Dispacher
  // REFCOUNT: the return of this method is counted as a refcount
  YAP6__CORE__Value* (*FETCH)(YAP6__CORE__Dispatcher* self,
                               YAP6__CORE__Value* value, 
                               YAP6__CORE__Value* wants);
  // REFCOUNT: the return of this method is counted as a refcount
  YAP6__CORE__Value* (*STORE)(YAP6__CORE__Dispatcher* self,
                               YAP6__CORE__Value* value, 
                               YAP6__CORE__Value* newvalue);
};

extern YAP6__CORE__ScalarDispatcher* yap6_const_scalar_dispatcher;
extern void yap6_scalar_dispatcher_init();
extern YAP6__CORE__Scalar* yap6_scalar_create(YAP6__CORE__Value* initialValue);
extern void yap6_scalar_dispatcher_destr();

struct YAP6__CORE__ListDispatcher {
  YAP6__BASE__Value
  YAP6__CORE__Dispatcher* dispatcher;
  YAP6__BASE__Dispacher
  // Lookup returns the value or the proxy value
  // REFCOUNT: the return of this method is counted as a refcount
  YAP6__CORE__Scalar* (*LOOKP)(YAP6__CORE__Dispatcher* self,
                               YAP6__CORE__Value* value, 
                               YAP6__CORE__int* index);
  // Exists doesn't vivifies and returns only if it exists,
  // else return NULL
  // REFCOUNT: the return of this method is counted as a refcount
  YAP6__CORE__Scalar* (*EXIST)(YAP6__CORE__Dispatcher* self,
                               YAP6__CORE__Value* value, 
                               YAP6__CORE__int* index);
  // Store without lookup returns the old value only if it exists,
  // else return NULL
  // REFCOUNT: the return of this method is counted as a refcount
  YAP6__CORE__Value*  (*STORE)(YAP6__CORE__Dispatcher* self,
                               YAP6__CORE__Value* value, 
                               YAP6__CORE__int* index,
                               YAP6__CORE__Value* newvalue);
  // Delete removes the key and returns it.
  // REFCOUNT: the return of this method is counted as a refcount
  YAP6__CORE__Scalar* (*DELET)(YAP6__CORE__Dispatcher* self,
                               YAP6__CORE__Value* value, 
                               YAP6__CORE__int* index);
  // returns the number of elements
  // REFCOUNT: the return of this method is counted as a refcount
  YAP6__CORE__int*    (*ELEMS)(YAP6__CORE__Dispatcher* self,
                               YAP6__CORE__Value* value);
};

/* list support */
struct YAP6__CORE__List {
  YAP6__BASE__Value
  YAP6__CORE__ListDispatcher* dispatcher;
  int length;
  YAP6__CORE__Value** items;
};

extern YAP6__CORE__ListDispatcher* yap6_const_list_dispatcher;
extern void yap6_list_dispatcher_init();
extern YAP6__CORE__List* yap6_list_create();
extern void yap6_list_dispatcher_destr();

/* pair support */
/*
 * The YAP6__CORE__PairDispatcher is a type of container that
 * also implements the GTKEY GTVAL STVAL methods.
 */
struct YAP6__CORE__PairDispatcher {
  YAP6__BASE__Value
  YAP6__CORE__Dispatcher* dispatcher;
  YAP6__BASE__Dispacher
  // REFCOUNT: the return of this method is counted as a refcount
  YAP6__CORE__Value* (*GTKEY)(YAP6__CORE__Dispatcher* self,
                               YAP6__CORE__Value* value);
  // REFCOUNT: the return of this method is counted as a refcount
  YAP6__CORE__Value* (*GTVAL)(YAP6__CORE__Dispatcher* self,
                               YAP6__CORE__Value* value);
  // REFCOUNT: the return of this method is counted as a refcount
  YAP6__CORE__Value* (*STVAL)(YAP6__CORE__Dispatcher* self,
                              YAP6__CORE__Value* value,
                              YAP6__CORE__Value* newval);
};

struct YAP6__CORE__Pair {
  YAP6__BASE__Value
  YAP6__CORE__PairDispatcher* dispatcher;
  YAP6__CORE__Value* key;
  YAP6__CORE__Value* value;
};

extern YAP6__CORE__PairDispatcher* yap6_const_pair_dispatcher;
extern void yap6_pair_dispatcher_init();
extern YAP6__CORE__Pair* yap6_pair_create(YAP6__CORE__Value* key, YAP6__CORE__Value* value);
extern void yap6_pair_dispatcher_destr();

struct YAP6__CORE__HashDispatcher {
  YAP6__BASE__Value
  YAP6__CORE__Dispatcher* dispatcher;
  YAP6__BASE__Dispacher
  // REFCOUNT: the return of this method is counted as a refcount
  // Lookup returns the value or the proxy value
  YAP6__CORE__Scalar* (*LOOKP)(YAP6__CORE__Dispatcher* self,
                               YAP6__CORE__Value* value, 
                               YAP6__CORE__Value* key);
  // Exists doesn't vivifies and returns only if it exists,
  // else return NULL
  // REFCOUNT: the return of this method is counted as a refcount
  YAP6__CORE__Scalar* (*EXIST)(YAP6__CORE__Dispatcher* self,
                               YAP6__CORE__Value* value, 
                               YAP6__CORE__Value* key);
  // Store without lookup returns the old value only if it exists,
  // else return NULL
  // REFCOUNT: the return of this method is counted as a refcount
  YAP6__CORE__Value*  (*STORE)(YAP6__CORE__Dispatcher* self,
                               YAP6__CORE__Value* value, 
                               YAP6__CORE__Value* key,
                               YAP6__CORE__Value* newvalue);
  // Delete removes the key and returns it.
  // REFCOUNT: the return of this method is counted as a refcount
  YAP6__CORE__Scalar* (*DELET)(YAP6__CORE__Dispatcher* self,
                               YAP6__CORE__Value* value, 
                               YAP6__CORE__Value* key);
  // returns the number of elements
  // REFCOUNT: the return of this method is counted as a refcount
  YAP6__CORE__int*    (*ELEMS)(YAP6__CORE__Dispatcher* self,
                               YAP6__CORE__Value* value);

};

struct YAP6__CORE__Hash {
  YAP6__BASE__Value
  YAP6__CORE__HashDispatcher* dispatcher;
  int length;
  YAP6__CORE__Pair** pairs;
};


// the capture object doesn't need any custom methods, as scalar it
// returns the invocant, as list the positional and as hash the named
// arguments.
struct YAP6__CORE__Capture {
  YAP6__BASE__Value
  YAP6__CORE__Dispatcher* dispatcher;
  YAP6__CORE__Value* invocant;
  YAP6__CORE__Hash* named;
  YAP6__CORE__List* positional;
};

#include "yap6_lowl_macros.h"

#endif