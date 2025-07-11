*
* $Id$
*
* $Log$
* Revision 1.4  1999/06/18 13:30:12  couet
* - qcardl.inc was empty: It is now removed and not used.
*   Comment END CDE removed.
*
* Revision 1.3  1999/06/18 12:04:45  couet
* - The version is now defined in one central place
*
* Revision 1.2  1996/04/18 16:11:25  mclareni
* Incorporate changes from J.Zoll for version 3.77
*
* Revision 1.1.1.1  1996/03/06 10:47:17  mclareni
* Zebra
*
*
#include "zebra/pilot.h"
      SUBROUTINE MZEBRA (LIST)

C-    Initialise memory manager,  user called

#include "zebra/zbcd.inc"
#include "zebra/zbcdch.inc"
#include "zebra/zceta.inc"
#include "zebra/zheadp.inc"
#include "zebra/zmach.inc"
#include "zebra/znatur.inc"
#include "zebra/zstate.inc"
#include "zebra/zunit.inc"
#include "zebra/mqsysh.inc"
#include "zebra/mzcl.inc"
#include "zebra/jzuc.inc"
#include "zebra/rzcount.inc"
#include "zebra/rzclun.inc"
#include "zebra/rzcstr.inc"
*
      CHARACTER*4 CVERSN
      DIMENSION    LIST(9), INKEYS(3)
      CHARACTER    VIDQQ*20

#if defined(CERNLIB_QMVDS)
      SAVE         INIT, INKEYS
#endif
#include "zebra/zfatalch.inc"
#if defined(CERNLIB_QHOLL)
      DATA  INKEYS / 4HEBRA, 4HINIT, 4HDONE /
#endif
#if !defined(CERNLIB_QHOLL)
      DATA  INKEYS / 2345432, 3456543, 4567654 /
#endif
*
#include "zebra/qversion.inc"
      WRITE(CVERSN,'(F4.2)') QVERSN
      VIDQQ = '@(#)ZEMQ     '//CVERSN//'>'
*
C--                Check re-entry to MZEBRA
C
C     DO 11  J=1,3
C     IF (MQKEYS(J).NE.INKEYS(J))  GO TO 12
C  11 CONTINUE
C     RETURN
      CALL CLEFT (VIDQQ,1,0)

   12 NQSTOR = -1
      JQSTOR = -9
CUS Explicitely zero the contents of the common to reduce compiler warnings
CUS same further down
CUS      CALL VZERO (NQOFFT,66)
      CALL VZERO (NQOFFT,16)
      CALL VZERO (NQOFFS,16)
      CALL VZERO (NQALLO,16)
      NQIAM = 0
      LQATAB = 0
      LQASTO = 0
      LQBTIS = 0
      LQWKTB = 0
      NQWKTB = 0
      LQWKFZ = 0
      CALL VZERO(MQKEYS, 3)
      NQINIT = 0
      NQTSYS = 0
      NQM99 = 0
      NQPERM = 0
      NQFATA = 0
      NQCASE = 0
      NQTRAC = 0
CUS

C--                Initialize all passive COMMONs

      CALL MZINCO (LIST)
      NQDCUT = 201
      NQWCUT = 500

      CALL UCOPY (INKEYS,MQKEYS,3)

C----              Clear /MZCL/, /JZUC/, /RZCOUNT/, /RZCSTR/

CUS    CALL VZERO (NQLN, 28)
      NQLN = 0
      NQLS = 0
      NQNIO = 0
      NQID = 0
      NQNL = 0
      NQNS = 0
      NQND = 0
      CALL VZERO(NQIOCH, 16)
      NQLNOR = 0
      NQLMAX = 0
      NQLPTH = 0
      NQRMAX = 0
      IQLPCT = 0
CUS      CALL VZERO (LQJZ, 16)
      LQJZ = 0
      LQUP = 0
      LQDW = 0
      LQSV = 0
      LQAN = 0
      JQLEV = 0
      CALL VZERO(JQFLAG, 10)
CUS
      CALL VZERO (NSTRIP, MAXFILES)
      JQLEV = -1

      RZXIO(1) = 0.
      RZXIO(2) = 0.

      IMODEH   = 0

      CALL VFILL (IQFENC,4,IQNIL)


C----              Test validity of ZFATAL

      NQINIT = INIT
      CALL ZFATAL
      CALL ZFATAM ('.')
      NQINIT = -1
C-        force loading for "what"
      IF (NQSTOR.EQ.99)  CALL MZVERS
      RETURN
      END
