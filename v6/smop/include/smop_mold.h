
#ifndef SMOP_Mold_H
#define SMOP_Mold_H

#include <smop.h>


/* Please see
http://www.perlfoundation.org/perl6/index.cgi?smop_mold
*/
extern SMOP__Object* SMOP__Mold;
SMOP__Object* SMOP__Mold_create(int registers,SMOP__Object** constants,int opcodes_len,int *opcodes); 
SMOP__Object* SMOP__Mold__Frame_create(SMOP__Object* interpreter,SMOP__Object* mold);

#endif