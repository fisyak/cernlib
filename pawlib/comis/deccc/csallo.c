/*
 * $Id$
 *
 * $Log$
 * Revision 1.9  1999/11/15 13:36:24  couet
 * - cfortran was not taken from the right place
 *
 * Revision 1.8  1997/10/21 17:01:54  mclareni
 * Get csallo.c compiled on VMS
 *
 * Revision 1.7  1997/07/23 08:03:56  couet
 * - final (?) changes to make the dynamic memory allocation working on all
 *   platforms (LINUX, UNIX and 64 bits machines like alpha).
 *
 * Revision 1.6  1997/07/18 15:17:57  berejnoi
 * using cfortran.h
 *
 * Revision 1.5  1997/07/14 07:57:50  berejnoi
 * bug fixed in csfree
 *
 * Revision 1.4  1997/06/03 08:49:00  berejnoi
 * new routine csfree
 *
 * Revision 1.3  1997/03/14 12:02:23  mclareni
 * WNT mods
 *
 * Revision 1.2.2.1  1997/01/21 11:34:42  mclareni
 * All mods for Winnt 96a on winnt branch
 *
 * Revision 1.2  1996/03/14 13:44:10  berezhno
 * mods for WINNT
 *
 * Revision 1.1.1.1  1996/02/26 17:16:55  mclareni
 * Comis
 *
 */
#include "comis/pilot.h"
/*CMZ :  1.14/02 17/05/93  10.21.29  by  Vladimir Berezhnoi*/
/*-- Author :*/

#include <cfortran/cfortran.h>
#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include "comis/mdpool.h"

unsigned long iqpntr = 0;

/*
  On some 64bit architectures/OS versions, e.g. Darwin, the space allocated by 
  malloc at runtime ends up at a very different memory region than expected.
  As a work around, we allocate a static piece of memory which we use to allocate
  the space out instead. Rather than doing it only on Darwin, it's now generally done
  on 64bit architectures.
*/
#if defined(CERNLIB_QMLXIA64)
#define MAXSTORE 400000
typedef struct {
  char buffer[MAXSTORE];
  unsigned int current;
} store_;
store_ STORE;
#endif

#if defined(CERNLIB_QX_SC)
int type_of_call csallo_(lenb)
#endif
#if defined(CERNLIB_QXNO_SC)
int type_of_call csallo(lenb)
#endif
#if defined(CERNLIB_QXCAPT)
int type_of_call CSALLO(lenb)
#endif
 int *lenb;
{
  unsigned long lpntr;
  unsigned int pntr;
  if (! iqpntr){
    iqpntr = (unsigned long)MDPOOL.iq;
#if defined(CERNLIB_QMLXIA64)
    STORE.current = 0;
#endif
  }
#if defined(CERNLIB_QMLXIA64)
  lpntr = (unsigned long)(&STORE.buffer[STORE.current]);
  STORE.current += *lenb;
  if (STORE.current+*lenb > MAXSTORE){
    fprintf(stderr,
	    "CSALLO: not enough memory to allocate %d bytes\n", *lenb);
    exit(EXIT_FAILURE);
  }
#else
  lpntr= (unsigned long)( malloc(*lenb) );
#endif
  if (! lpntr) {
    fprintf(stderr,
	    "CSALLO: not enough dynamic memory to allocate %d bytes\n", *lenb);
    exit(EXIT_FAILURE);
  }

  if (lpntr < iqpntr) {
    fprintf(stderr, "CSALLO: heap below bss?!");
    fprintf(stderr, "  Try linking against pawlib statically.\n");
    exit(EXIT_FAILURE);
  }
  else if (lpntr - iqpntr > UINT_MAX) {
    fprintf(stderr,
	"CSALLO: pointer difference too large to be represented by integer.\n"
	"You probably need to link PAW statically on 64-bit systems.\n");
        exit(EXIT_FAILURE);
  }
  pntr=lpntr - iqpntr;
  return pntr;
}

#if defined(CERNLIB_QX_SC)
void type_of_call csfree_(mpntr)
#endif
#if defined(CERNLIB_QXNO_SC)
void type_of_call csfree(mpntr)
#endif
#if defined(CERNLIB_QXCAPT)
void type_of_call CSFREE(mpntr)
#endif
unsigned  mpntr[];
{
  /* US On 64bit we generally use space from the common block */
#if !defined(CERNLIB_QMLXIA64)
  void *pntr;
  pntr = (void*)(mpntr[0]+iqpntr);
  free(pntr);
#endif
}
