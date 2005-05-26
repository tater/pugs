#include "EXTERN.h"
#include "perl.h"
#include "embed.h"

PerlInterpreter * perl5_init ( int argc, char **argv );
char * perl5_SvPV ( SV * sv );
SV * perl5_newSVpv ( char * pv );
SV * perl5_newSViv ( int iv );
SV * perl5_call(char *subname, int argc, SV** args, int cxt);
bool perl5_can(SV *inv, char *subname);
SV * perl5_eval(char *code, int cxt);
