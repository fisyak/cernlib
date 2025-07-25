/* Dummy file to avoid undefined symbols in the library */
/* Kevin McCarty, 14 Jan 2003 */
/* Last revised 22 November 2005 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Want the dummy functions to be weakly defined so they may be overridden
 * without error. */

#define kludge(x)    #x
#define stringify(x) kludge(x)
#define underline(x) __ ## x

#define DUMMY(domain, UPPERNAME, fortranname_, returntype) \
returntype fortranname_() {print_dummy(#domain,#UPPERNAME);}

#ifdef __APPLE__
#define WEAKDUMMY(domain, UPPERNAME, fortranname_, returntype)		\
static returntype underline(fortranname_)() {print_dummy(#domain,#UPPERNAME);} \
void fortranname_() { underline(fortranname_)();}
#else
#define WEAKDUMMY(domain, UPPERNAME, fortranname_, returntype)		\
static returntype underline(fortranname_)() {print_dummy(#domain,#UPPERNAME);} \
void fortranname_() \
	__attribute__ ((weak, alias (stringify(underline(fortranname_))) ))
#endif
static void print_dummy(const char *domain, const char *function)
{
  fprintf(stderr, "GEANT 3.21: Now in dummy %s routine.\n", function);
  fprintf(stderr,
"If you see this message, you are presumably trying to call (possibly\n"
"indirectly) the %s routine");

  if (strcmp(domain, "Fluka") == 0)
    fprintf(stderr,
" in the FLUKA library.\n"
"FLUKA is unfortunately not available in this distribution of CERNLIB for\n"
"licensing reasons"
#if defined (CERNLIB_DEBIAN)
"; please see the file /usr/share/doc/geant321/README.Debian\n"
"for details.\n"
#else
".\n"
#endif
    );
  
  else if (strcmp(domain, "User") == 0)
    fprintf(stderr, ".  This routine is not built into GEANT;\n"
"you must write code for it yourself.  Please see the documentation"
#if defined (CERNLIB_DEBIAN)
"\n(for instance in the geant321-doc package)"
#endif
".\n");
  
  exit(EXIT_FAILURE);
}

/* Functions that the user is supposed to set up */
WEAKDUMMY(User, UGINIT, uginit_, void);
WEAKDUMMY(User, UGLAST, uglast_, void);

/* N.B.  When the libgeant321 dynamic soversion is bumped, at the same time
 * everything below this point except the dummy FLDIST and FLINIT subroutines
 * may be deleted; those should be turned into weak aliases in case anyone
 * wants to create a separate GEANT-FLUKA library. */

/* From src/geant321/fluka (not the complete set of functions, just
 * those referenced from external files) */
WEAKDUMMY(Fluka, DOST,   dost_,   double);
WEAKDUMMY(Fluka, EEXLVL, eexlvl_, void);
WEAKDUMMY(Fluka, EVENTV, eventv_, void);
WEAKDUMMY(Fluka, EVEVAP, evevap_, void);
WEAKDUMMY(Fluka, EVVINI, evvini_, void);
WEAKDUMMY(Fluka, FKENER, fkener_, double);
WEAKDUMMY(Fluka, FKZERO, fkzero_, void);
WEAKDUMMY(Fluka, NIZLNW, nizlnw_, void);
WEAKDUMMY(Fluka, NUCREL, nucrel_, void);
WEAKDUMMY(Fluka, RACO,   raco_,   void);
WEAKDUMMY(Fluka, SAMCST, samcst_, void);
WEAKDUMMY(Fluka, SIGEL,  sigel_,  void);
WEAKDUMMY(Fluka, SITSAO, sitsao_, double);

/* The following dummy functions are added due to the removal
 * of the corresponding code from GEANT (it is also part of FLUKA).
 * We are constrained to keep the ABI for the dynamic library, so
 * these dummy functions must be kept until next time the libgeant321
 * soversion is changed. */

/* From src/geant321/fiface */
DUMMY(Fluka, FLDIST, fldist_, void);
DUMMY(Fluka, FLINIT, flinit_, void);
DUMMY(Fluka, FLUFIN, flufin_, void);

/* From src/geant321/miface */
DUMMY(Fluka, GFMFIN, gfmfin_, void);
DUMMY(Fluka, GFMDIS, gfmdis_, void);

/* From src/geant321/block */
DUMMY(Fluka, FDEVAP, fdevap_, void);
DUMMY(Fluka, FDNOPT, fdnopt_, void);
DUMMY(Fluka, FDPREE, fdpree_, void);
DUMMY(Fluka, FLKDT1, flkdt1_, void);
DUMMY(Fluka, FLKDT2, flkdt2_, void);
DUMMY(Fluka, FLKDT3, flkdt3_, void);
DUMMY(Fluka, FLKDT4, flkdt4_, void);
DUMMY(Fluka, FLKDT5, flkdt5_, void);
DUMMY(Fluka, FLKDT6, flkdt6_, void);
DUMMY(Fluka, FLKDT7, flkdt7_, void);

/* From src/geant321/peanut */
DUMMY(Fluka, BIMNXT, bimnxt_, void);   /* alternate entry to BIMSEL */
DUMMY(Fluka, BIMSEL, bimsel_, void);
DUMMY(Fluka, COSLEG, cosleg_, double);
DUMMY(Fluka, FEKFNC, fekfnc_, double);
DUMMY(Fluka, FPFRNC, fpfrnc_, double);
DUMMY(Fluka, FRADNC, fradnc_, double);
DUMMY(Fluka, FRHINC, frhinc_, double);
DUMMY(Fluka, FRHONC, frhonc_, double);
DUMMY(Fluka, NCLVFX, nclvfx_, double); /* alternate entry to PFNCLV */
DUMMY(Fluka, NCLVIN, nclvin_, void);
DUMMY(Fluka, NCLVST, nclvst_, void);
DUMMY(Fluka, NUCNUC, nucnuc_, void);
DUMMY(Fluka, NWINXT, nwinxt_, void);   /* alternate entry to NWISEL */
DUMMY(Fluka, NWISEL, nwisel_, void);
DUMMY(Fluka, PEANUT, peanut_, void);
DUMMY(Fluka, PFNCLV, pfnclv_, double);
DUMMY(Fluka, PHDSET, phdset_, void);
DUMMY(Fluka, PHDWLL, phdwll_, void);
DUMMY(Fluka, PIOABS, pioabs_, void);
DUMMY(Fluka, PREPRE, prepre_, void);
DUMMY(Fluka, RSCOMP, rscomp_, void);   /* alternate entry to SBCOMP */
DUMMY(Fluka, RSTNXT, rstnxt_, void);   /* alternate entry to RSTSEL */
DUMMY(Fluka, RSTSEL, rstsel_, void);
DUMMY(Fluka, SBCOMP, sbcomp_, void);
DUMMY(Fluka, SIGFER, sigfer_, void);
DUMMY(Fluka, UMOFIN, umofin_, void);
DUMMY(Fluka, XINNEU, xinneu_, double);
DUMMY(Fluka, XINPRO, xinpro_, double);

/* The following dummy common blocks are added for the same reason.
 * The number of bytes required was determined by inspecting the existing
 * shared libraries in the 12 official Debian architectures and determining
 * the maximum size of each common block there. */

#define COMMON(fortranname_, size) \
        struct { char c[size]; } fortranname_ = { { 0, } }

COMMON(fkadhn_, 1376);
COMMON(fkadhp_, 3712);
COMMON(fkbala_,  288);
COMMON(fkcd97_, 1152);
COMMON(fkchpa_, 1472);
COMMON(fkchpr_,  576);
COMMON(fkcmcy_,  176);
COMMON(fkcomc_, 7424);
COMMON(fkcosp_,   64);
COMMON(fkdecc_,10816);
COMMON(fkdech_, 4328);
COMMON(fkenco_,   16);
COMMON(fkeva0_,60960);
COMMON(fkfinu_,52000);
COMMON(fkhadf_,  352);
COMMON(fkheac_,   96);
COMMON(fkheav_, 5408);
COMMON(fkhet7_,   64);
COMMON(fkhetp_,   32);
COMMON(fkhigf_, 1632);
COMMON(fkidgb_,   16);
COMMON(fkinpf_,   32);
COMMON(fkisot_,10208);
COMMON(fkmapa_, 5824);
COMMON(fknegx_,  128);
COMMON(fknuct_,   16);
COMMON(fknuda_, 1248);
COMMON(fknuge_, 1120);
COMMON(fknugi_,26944);
COMMON(fknuii_, 1888);
COMMON(fknule_,18048);
COMMON(fknupw_,   32);
COMMON(fkpapr_, 2400);
COMMON(fkpare_,  256);
COMMON(fkparn_, 7296);
COMMON(fkpart_, 9696);
COMMON(fkploc_, 2864);
COMMON(fkquar_,  832);
COMMON(fkreac_,50976);
COMMON(fkredv_, 2368);
COMMON(fkresn_,  256);
COMMON(fkrun_,    32);
COMMON(fkslop_,  608);
COMMON(fkxsep_,13600);

