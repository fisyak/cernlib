#ifndef _JETSET74_H
#define _JETSET74_H

#ifdef __cplusplus
extern "C" {
#endif

PROTOCCALLSFFUN2(INT,KLU,klu,INT,INT)
#define KLU(A2,A3)  CCALLSFFUN2(KLU,klu,INT,INT,A2,A3)

PROTOCCALLSFFUN2(FLOAT,PLU,plu,INT,INT)
#define PLU(A2,A3)  CCALLSFFUN2(PLU,plu,INT,INT,A2,A3)

PROTOCCALLSFFUN4(FLOAT,PYCTQ2,pyctq2,INT,INT,FLOAT,FLOAT)
#define PYCTQ2(A2,A3,A4,A5)  CCALLSFFUN4(PYCTQ2,pyctq2,INT,INT,FLOAT,FLOAT,A2,A3,A4,A5)

PROTOCCALLSFFUN1(DOUBLE,PYDILN,pydiln,DOUBLE)
#define PYDILN(A2)  CCALLSFFUN1(PYDILN,pydiln,DOUBLE,A2)

PROTOCCALLSFFUN1(INT,LUCHGE,luchge,INT)
#define LUCHGE(A2)  CCALLSFFUN1(LUCHGE,luchge,INT,A2)

PROTOCCALLSFFUN1(INT,LUCOMP,lucomp,INT)
#define LUCOMP(A2)  CCALLSFFUN1(LUCOMP,lucomp,INT,A2)

PROTOCCALLSFFUN1(FLOAT,PYGAMM,pygamm,FLOAT)
#define PYGAMM(A2)  CCALLSFFUN1(PYGAMM,pygamm,FLOAT,A2)

PROTOCCALLSFFUN3(FLOAT,PYHFTH,pyhfth,FLOAT,FLOAT,FLOAT)
#define PYHFTH(A2,A3,A4)  CCALLSFFUN3(PYHFTH,pyhfth,FLOAT,FLOAT,FLOAT,A2,A3,A4)

PROTOCCALLSFFUN3(FLOAT,PYSPEN,pyspen,FLOAT,FLOAT,INT)
#define PYSPEN(A2,A3,A4)  CCALLSFFUN3(PYSPEN,pyspen,FLOAT,FLOAT,INT,A2,A3,A4)

PROTOCCALLSFFUN2(DOUBLE,RKDOT,rkdot,DOUBLEV,DOUBLEV)
#define RKDOT(A2,A3)  CCALLSFFUN2(RKDOT,rkdot,DOUBLEV,DOUBLEV,A2,A3)

PROTOCCALLSFFUN1(DOUBLE,RKRAND,rkrand,INT)
#define RKRAND(A2)  CCALLSFFUN1(RKRAND,rkrand,INT,A2)

PROTOCCALLSFFUN6(COMPLEX,RKZF,rkzf,INT,DOUBLEV,DOUBLEV,DOUBLE,INT,DOUBLEV)
#define RKZF(A2,A3,A4,A5,A6,A7)  CCALLSFFUN6(RKZF,rkzf,INT,DOUBLEV,DOUBLEV,DOUBLE,INT,DOUBLEV,A2,A3,A4,A5,A6,A7)

PROTOCCALLSFFUN3(COMPLEX,RKZPR,rkzpr,INT,DOUBLEV,DOUBLEV)
#define RKZPR(A2,A3,A4)  CCALLSFFUN3(RKZPR,rkzpr,INT,DOUBLEV,DOUBLEV,A2,A3,A4)

PROTOCCALLSFFUN4(COMPLEX,RKZSF,rkzsf,INT,DOUBLEV,INT,DOUBLEV)
#define RKZSF(A2,A3,A4,A5)  CCALLSFFUN4(RKZSF,rkzsf,INT,DOUBLEV,INT,DOUBLEV,A2,A3,A4,A5)

PROTOCCALLSFFUN1(FLOAT,RLU,rlu,INT)
#define RLU(A2)  CCALLSFFUN1(RLU,rlu,INT,A2)

PROTOCCALLSFFUN1(FLOAT,ULALEM,ulalem,FLOAT)
#define ULALEM(A2)  CCALLSFFUN1(ULALEM,ulalem,FLOAT,A2)

PROTOCCALLSFFUN1(FLOAT,ULALPS,ulalps,FLOAT)
#define ULALPS(A2)  CCALLSFFUN1(ULALPS,ulalps,FLOAT,A2)

PROTOCCALLSFFUN2(FLOAT,ULANGL,ulangl,FLOAT,FLOAT)
#define ULANGL(A2,A3)  CCALLSFFUN2(ULANGL,ulangl,FLOAT,FLOAT,A2,A3)

PROTOCCALLSFFUN1(FLOAT,ULMASS,ulmass,INT)
#define ULMASS(A2)  CCALLSFFUN1(ULMASS,ulmass,INT,A2)

PROTOCCALLSFSUB5(LU1ENT,lu1ent,INT,INT,FLOAT,FLOAT,FLOAT)
#define LU1ENT(A1,A2,A3,A4,A5)  CCALLSFSUB5(LU1ENT,lu1ent,INT,INT,FLOAT,FLOAT,FLOAT,A1,A2,A3,A4,A5)

PROTOCCALLSFSUB4(LU2ENT,lu2ent,INT,INT,INT,FLOAT)
#define LU2ENT(A1,A2,A3,A4)  CCALLSFSUB4(LU2ENT,lu2ent,INT,INT,INT,FLOAT,A1,A2,A3,A4)

PROTOCCALLSFSUB7(LU3ENT,lu3ent,INT,INT,INT,INT,FLOAT,FLOAT,FLOAT)
#define LU3ENT(A1,A2,A3,A4,A5,A6,A7)  CCALLSFSUB7(LU3ENT,lu3ent,INT,INT,INT,INT,FLOAT,FLOAT,FLOAT,A1,A2,A3,A4,A5,A6,A7)

PROTOCCALLSFSUB11(LU4ENT,lu4ent,INT,INT,INT,INT,INT,FLOAT,FLOAT,FLOAT,FLOAT,FLOAT,FLOAT)
#define LU4ENT(A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11)  CCALLSFSUB11(LU4ENT,lu4ent,INT,INT,INT,INT,INT,FLOAT,FLOAT,FLOAT,FLOAT,FLOAT,FLOAT,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11)

PROTOCCALLSFSUB1(LUBOEI,luboei,INT)
#define LUBOEI(A1)  CCALLSFSUB1(LUBOEI,luboei,INT,A1)

PROTOCCALLSFSUB1(LUCELL,lucell,PINT)
#define LUCELL(A1)  CCALLSFSUB1(LUCELL,lucell,PINT,A1)

PROTOCCALLSFSUB1(LUCLUS,luclus,PINT)
#define LUCLUS(A1)  CCALLSFSUB1(LUCLUS,luclus,PINT,A1)

PROTOCCALLSFSUB1(LUDECY,ludecy,INT)
#define LUDECY(A1)  CCALLSFSUB1(LUDECY,ludecy,INT,A1)

PROTOCCALLSFSUB1(LUEDIT,luedit,INT)
#define LUEDIT(A1)  CCALLSFSUB1(LUEDIT,luedit,INT,A1)

PROTOCCALLSFSUB2(LUEEVT,lueevt,INT,FLOAT)
#define LUEEVT(A1,A2)  CCALLSFSUB2(LUEEVT,lueevt,INT,FLOAT,A1,A2)

PROTOCCALLSFSUB2(LUERRM,luerrm,INT,BYTE)
#define LUERRM(A1,A2)  CCALLSFSUB2(LUERRM,luerrm,INT,BYTE,A1,A2)

PROTOCCALLSFSUB0(LUEXEC,luexec)
#define LUEXEC() CCALLSFSUB0(LUEXEC,luexec)

PROTOCCALLSFSUB4(LUFOWO,lufowo,PFLOAT,PFLOAT,PFLOAT,PFLOAT)
#define LUFOWO(A1,A2,A3,A4)  CCALLSFSUB4(LUFOWO,lufowo,PFLOAT,PFLOAT,PFLOAT,PFLOAT,A1,A2,A3,A4)

PROTOCCALLSFSUB1(LUGIVE,lugive,BYTE)
#define LUGIVE(A1)  CCALLSFSUB1(LUGIVE,lugive,BYTE,A1)

PROTOCCALLSFSUB1(LUHEPC,luhepc,INT)
#define LUHEPC(A1)  CCALLSFSUB1(LUHEPC,luhepc,INT,A1)

PROTOCCALLSFSUB1(LUINDF,luindf,INT)
#define LUINDF(A1)  CCALLSFSUB1(LUINDF,luindf,INT,A1)

PROTOCCALLSFSUB2(LUJMAS,lujmas,PFLOAT,PFLOAT)
#define LUJMAS(A1,A2)  CCALLSFSUB2(LUJMAS,lujmas,PFLOAT,PFLOAT,A1,A2)

PROTOCCALLSFSUB2(LUJOIN,lujoin,INT,INTV)
#define LUJOIN(A1,A2)  CCALLSFSUB2(LUJOIN,lujoin,INT,INTV,A1,A2)

PROTOCCALLSFSUB4(LUKFDI,lukfdi,INT,INT,PINT,PINT)
#define LUKFDI(A1,A2,A3,A4)  CCALLSFSUB4(LUKFDI,lukfdi,INT,INT,PINT,PINT,A1,A2,A3,A4)

PROTOCCALLSFSUB1(LULIST,lulist,INT)
#define LULIST(A1)  CCALLSFSUB1(LULIST,lulist,INT,A1)

PROTOCCALLSFSUB0(LULOGO,lulogo)
#define LULOGO() CCALLSFSUB0(LULOGO,lulogo)

PROTOCCALLSFSUB2(LUNAME,luname,INT,PBYTE)
#define LUNAME(A1,A2)  CCALLSFSUB2(LUNAME,luname,INT,PBYTE,A1,A2)

PROTOCCALLSFSUB2(LUONIA,luonia,INT,FLOAT)
#define LUONIA(A1,A2)  CCALLSFSUB2(LUONIA,luonia,INT,FLOAT,A1,A2)

PROTOCCALLSFSUB1(LUPREP,luprep,INT)
#define LUPREP(A1)  CCALLSFSUB1(LUPREP,luprep,INT,A1)

PROTOCCALLSFSUB3(LUPTDI,luptdi,INT,PFLOAT,PFLOAT)
#define LUPTDI(A1,A2,A3)  CCALLSFSUB3(LUPTDI,luptdi,INT,PFLOAT,PFLOAT,A1,A2,A3)

PROTOCCALLSFSUB6(LURADK,luradk,FLOAT,PINT,PFLOAT,PFLOAT,PFLOAT,PFLOAT)
#define LURADK(A1,A2,A3,A4,A5,A6)  CCALLSFSUB6(LURADK,luradk,FLOAT,PINT,PFLOAT,PFLOAT,PFLOAT,PFLOAT,A1,A2,A3,A4,A5,A6)

PROTOCCALLSFSUB7(LUDBRB,ludbrb,INT,INT,FLOAT,FLOAT,DOUBLE,DOUBLE,DOUBLE)
#define LUDBRB(A1,A2,A3,A4,A5,A6,A7)  CCALLSFSUB7(LUDBRB,ludbrb,INT,INT,FLOAT,FLOAT,DOUBLE,DOUBLE,DOUBLE,A1,A2,A3,A4,A5,A6,A7)

PROTOCCALLSFSUB5(LUROBO,lurobo,FLOAT,FLOAT,FLOAT,FLOAT,FLOAT)
#define LUROBO(A1,A2,A3,A4,A5)  CCALLSFSUB5(LUROBO,lurobo,FLOAT,FLOAT,FLOAT,FLOAT,FLOAT,A1,A2,A3,A4,A5)

PROTOCCALLSFSUB3(LUSHOW,lushow,INT,INT,FLOAT)
#define LUSHOW(A1,A2,A3)  CCALLSFSUB3(LUSHOW,lushow,INT,INT,FLOAT,A1,A2,A3)

PROTOCCALLSFSUB2(LUSPHE,lusphe,PFLOAT,PFLOAT)
#define LUSPHE(A1,A2)  CCALLSFSUB2(LUSPHE,lusphe,PFLOAT,PFLOAT,A1,A2)

PROTOCCALLSFSUB1(LUSTRF,lustrf,INT)
#define LUSTRF(A1)  CCALLSFSUB1(LUSTRF,lustrf,INT,A1)

PROTOCCALLSFSUB1(LUTABU,lutabu,INT)
#define LUTABU(A1)  CCALLSFSUB1(LUTABU,lutabu,INT,A1)

PROTOCCALLSFSUB4(LUTAUD,lutaud,INT,INT,INT,PINT)
#define LUTAUD(A1,A2,A3,A4)  CCALLSFSUB4(LUTAUD,lutaud,INT,INT,INT,PINT,A1,A2,A3,A4)

PROTOCCALLSFSUB1(LUTEST,lutest,INT)
#define LUTEST(A1)  CCALLSFSUB1(LUTEST,lutest,INT,A1)

PROTOCCALLSFSUB2(LUTHRU,luthru,PFLOAT,PFLOAT)
#define LUTHRU(A1,A2)  CCALLSFSUB2(LUTHRU,luthru,PFLOAT,PFLOAT,A1,A2)

PROTOCCALLSFSUB2(LUUPDA,luupda,INT,INT)
#define LUUPDA(A1,A2)  CCALLSFSUB2(LUUPDA,luupda,INT,INT,A1,A2)

PROTOCCALLSFSUB6(LUX3JT,lux3jt,PINT,FLOAT,INT,FLOAT,PFLOAT,PFLOAT)
#define LUX3JT(A1,A2,A3,A4,A5,A6)  CCALLSFSUB6(LUX3JT,lux3jt,PINT,FLOAT,INT,FLOAT,PFLOAT,PFLOAT,A1,A2,A3,A4,A5,A6)

PROTOCCALLSFSUB10(LUX4JT,lux4jt,PINT,FLOAT,INT,FLOAT,PINT,PFLOAT,PFLOAT,PFLOAT,PFLOAT,PFLOAT)
#define LUX4JT(A1,A2,A3,A4,A5,A6,A7,A8,A9,A10)  CCALLSFSUB10(LUX4JT,lux4jt,PINT,FLOAT,INT,FLOAT,PINT,PFLOAT,PFLOAT,PFLOAT,PFLOAT,PFLOAT,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10)

PROTOCCALLSFSUB7(LUXDIF,luxdif,INT,INT,INT,FLOAT,PFLOAT,PFLOAT,PFLOAT)
#define LUXDIF(A1,A2,A3,A4,A5,A6,A7)  CCALLSFSUB7(LUXDIF,luxdif,INT,INT,INT,FLOAT,PFLOAT,PFLOAT,PFLOAT,A1,A2,A3,A4,A5,A6,A7)

PROTOCCALLSFSUB3(LUXJET,luxjet,FLOAT,PINT,PFLOAT)
#define LUXJET(A1,A2,A3)  CCALLSFSUB3(LUXJET,luxjet,FLOAT,PINT,PFLOAT,A1,A2,A3)

PROTOCCALLSFSUB4(LUXKFL,luxkfl,INT,FLOAT,FLOAT,PINT)
#define LUXKFL(A1,A2,A3,A4)  CCALLSFSUB4(LUXKFL,luxkfl,INT,FLOAT,FLOAT,PINT,A1,A2,A3,A4)

PROTOCCALLSFSUB3(LUXTOT,luxtot,INT,FLOAT,PFLOAT)
#define LUXTOT(A1,A2,A3)  CCALLSFSUB3(LUXTOT,luxtot,INT,FLOAT,PFLOAT,A1,A2,A3)

PROTOCCALLSFSUB4(LUZDIS,luzdis,INT,INT,FLOAT,PFLOAT)
#define LUZDIS(A1,A2,A3,A4)  CCALLSFSUB4(LUZDIS,luzdis,INT,INT,FLOAT,PFLOAT,A1,A2,A3,A4)

PROTOCCALLSFSUB2(PDFSET,pdfset,PSTRINGV,PDOUBLE)
#define PDFSET(A1,A2)  CCALLSFSUB2(PDFSET,pdfset,PSTRINGV,PDOUBLE,A1,A2)

PROTOCCALLSFSUB0(PYDIFF,pydiff)
#define PYDIFF() CCALLSFSUB0(PYDIFF,pydiff)

PROTOCCALLSFSUB0(PYDOCU,pydocu)
#define PYDOCU() CCALLSFSUB0(PYDOCU,pydocu)

PROTOCCALLSFSUB0(PYEVNT,pyevnt)
#define PYEVNT() CCALLSFSUB0(PYEVNT,pyevnt)

PROTOCCALLSFSUB1(PYEVWT,pyevwt,PFLOAT)
#define PYEVWT(A1)  CCALLSFSUB1(PYEVWT,pyevwt,PFLOAT,A1)

PROTOCCALLSFSUB1(PYFRAM,pyfram,INT)
#define PYFRAM(A1)  CCALLSFSUB1(PYFRAM,pyfram,INT,A1)

PROTOCCALLSFSUB4(PYI3AU,pyi3au,FLOAT,FLOAT,PFLOAT,PFLOAT)
#define PYI3AU(A1,A2,A3,A4)  CCALLSFSUB4(PYI3AU,pyi3au,FLOAT,FLOAT,PFLOAT,PFLOAT,A1,A2,A3,A4)

PROTOCCALLSFSUB4(PYINIT,pyinit,STRING,STRING,STRING,FLOAT)
#define PYINIT(A1,A2,A3,A4)  CCALLSFSUB4(PYINIT,pyinit,STRING,STRING,STRING,FLOAT,A1,A2,A3,A4)

PROTOCCALLSFSUB1(PYINKI,pyinki,INT)
#define PYINKI(A1)  CCALLSFSUB1(PYINKI,pyinki,INT,A1)

PROTOCCALLSFSUB0(PYINPR,pyinpr)
#define PYINPR() CCALLSFSUB0(PYINPR,pyinpr)

PROTOCCALLSFSUB0(PYINRE,pyinre)
#define PYINRE() CCALLSFSUB0(PYINRE,pyinre)

PROTOCCALLSFSUB1(PYKCUT,pykcut,PINT)
#define PYKCUT(A1)  CCALLSFSUB1(PYKCUT,pykcut,PINT,A1)

PROTOCCALLSFSUB1(PYKLIM,pyklim,INT)
#define PYKLIM(A1)  CCALLSFSUB1(PYKLIM,pyklim,INT,A1)

PROTOCCALLSFSUB3(PYKMAP,pykmap,INT,INT,FLOAT)
#define PYKMAP(A1,A2,A3)  CCALLSFSUB3(PYKMAP,pykmap,INT,INT,FLOAT,A1,A2,A3)

PROTOCCALLSFSUB0(PYMAXI,pymaxi)
#define PYMAXI() CCALLSFSUB0(PYMAXI,pymaxi)

PROTOCCALLSFSUB1(PYMULT,pymult,INT)
#define PYMULT(A1)  CCALLSFSUB1(PYMULT,pymult,INT,A1)

PROTOCCALLSFSUB7(PYOFSH,pyofsh,INT,INT,INT,INT,FLOAT,PFLOAT,PFLOAT)
#define PYOFSH(A1,A2,A3,A4,A5,A6,A7)  CCALLSFSUB7(PYOFSH,pyofsh,INT,INT,INT,INT,FLOAT,PFLOAT,PFLOAT,A1,A2,A3,A4,A5,A6,A7)

PROTOCCALLSFSUB1(PYPILE,pypile,INT)
#define PYPILE(A1)  CCALLSFSUB1(PYPILE,pypile,INT,A1)

PROTOCCALLSFSUB1(PYQQBH,pyqqbh,PFLOAT)
#define PYQQBH(A1)  CCALLSFSUB1(PYQQBH,pyqqbh,PFLOAT,A1)

PROTOCCALLSFSUB0(PYRAND,pyrand)
#define PYRAND() CCALLSFSUB0(PYRAND,pyrand)

PROTOCCALLSFSUB2(PYREMN,pyremn,INT,INT)
#define PYREMN(A1,A2)  CCALLSFSUB2(PYREMN,pyremn,INT,INT,A1,A2)

PROTOCCALLSFSUB0(PYRESD,pyresd)
#define PYRESD() CCALLSFSUB0(PYRESD,pyresd)

PROTOCCALLSFSUB2(PYSAVE,pysave,INT,PINT)
#define PYSAVE(A1,A2)  CCALLSFSUB2(PYSAVE,pysave,INT,PINT,A1,A2)

PROTOCCALLSFSUB0(PYSCAT,pyscat)
#define PYSCAT() CCALLSFSUB0(PYSCAT,pyscat)

PROTOCCALLSFSUB2(PYSIGH,pysigh,PINT,PFLOAT)
#define PYSIGH(A1,A2)  CCALLSFSUB2(PYSIGH,pysigh,PINT,PFLOAT,A1,A2)

PROTOCCALLSFSUB4(PYSPLI,pyspli,INT,INT,PINT,PINT)
#define PYSPLI(A1,A2,A3,A4)  CCALLSFSUB4(PYSPLI,pyspli,INT,INT,PINT,PINT,A1,A2,A3,A4)

PROTOCCALLSFSUB2(PYSSPA,pysspa,INT,INT)
#define PYSSPA(A1,A2)  CCALLSFSUB2(PYSSPA,pysspa,INT,INT,A1,A2)

PROTOCCALLSFSUB3(PYSTAG,pystag,FLOAT,FLOAT,PFLOAT)
#define PYSTAG(A1,A2,A3)  CCALLSFSUB3(PYSTAG,pystag,FLOAT,FLOAT,PFLOAT,A1,A2,A3)

PROTOCCALLSFSUB1(PYSTAT,pystat,INT)
#define PYSTAT(A1)  CCALLSFSUB1(PYSTAT,pystat,INT,A1)

PROTOCCALLSFSUB3(PYSTEL,pystel,FLOAT,FLOAT,PFLOAT)
#define PYSTEL(A1,A2,A3)  CCALLSFSUB3(PYSTEL,pystel,FLOAT,FLOAT,PFLOAT,A1,A2,A3)

PROTOCCALLSFSUB4(PYSTFL,pystfl,INT,FLOAT,FLOAT,PFLOAT)
#define PYSTFL(A1,A2,A3,A4)  CCALLSFSUB4(PYSTFL,pystfl,INT,FLOAT,FLOAT,PFLOAT,A1,A2,A3,A4)

PROTOCCALLSFSUB4(PYSTFU,pystfu,INT,FLOAT,FLOAT,PFLOAT)
#define PYSTFU(A1,A2,A3,A4)  CCALLSFSUB4(PYSTFU,pystfu,INT,FLOAT,FLOAT,PFLOAT,A1,A2,A3,A4)

PROTOCCALLSFSUB3(PYSTGA,pystga,FLOAT,FLOAT,PFLOAT)
#define PYSTGA(A1,A2,A3)  CCALLSFSUB3(PYSTGA,pystga,FLOAT,FLOAT,PFLOAT,A1,A2,A3)

PROTOCCALLSFSUB6(PYSTGS,pystgs,DOUBLE,DOUBLE,DOUBLE,DOUBLE,INT,PDOUBLE)
#define PYSTGS(A1,A2,A3,A4,A5,A6)  CCALLSFSUB6(PYSTGS,pystgs,DOUBLE,DOUBLE,DOUBLE,DOUBLE,INT,PDOUBLE,A1,A2,A3,A4,A5,A6)

PROTOCCALLSFSUB6(PYSTHG,pysthg,INT,FLOAT,FLOAT,FLOAT,FLOAT,PFLOAT)
#define PYSTHG(A1,A2,A3,A4,A5,A6)  CCALLSFSUB6(PYSTHG,pysthg,INT,FLOAT,FLOAT,FLOAT,FLOAT,PFLOAT,A1,A2,A3,A4,A5,A6)

PROTOCCALLSFSUB3(PYSTPI,pystpi,FLOAT,FLOAT,PFLOAT)
#define PYSTPI(A1,A2,A3)  CCALLSFSUB3(PYSTPI,pystpi,FLOAT,FLOAT,PFLOAT,A1,A2,A3)

PROTOCCALLSFSUB3(PYSTPR,pystpr,FLOAT,FLOAT,PFLOAT)
#define PYSTPR(A1,A2,A3)  CCALLSFSUB3(PYSTPR,pystpr,FLOAT,FLOAT,PFLOAT,A1,A2,A3)

PROTOCCALLSFSUB1(PYTEST,pytest,INT)
#define PYTEST(A1)  CCALLSFSUB1(PYTEST,pytest,INT,A1)

PROTOCCALLSFSUB2(PYUPEV,pyupev,INT,PFLOAT)
#define PYUPEV(A1,A2)  CCALLSFSUB2(PYUPEV,pyupev,INT,PFLOAT,A1,A2)

PROTOCCALLSFSUB3(PYUPIN,pyupin,INT,STRING,FLOAT)
#define PYUPIN(A1,A2,A3)  CCALLSFSUB3(PYUPIN,pyupin,INT,STRING,FLOAT,A1,A2,A3)

PROTOCCALLSFSUB4(PYWAUX,pywaux,INT,FLOAT,FLOAT,PFLOAT)
#define PYWAUX(A1,A2,A3,A4)  CCALLSFSUB4(PYWAUX,pywaux,INT,FLOAT,FLOAT,PFLOAT,A1,A2,A3,A4)

PROTOCCALLSFSUB4(PYWIDT,pywidt,INT,FLOAT,PFLOAT,PFLOAT)
#define PYWIDT(A1,A2,A3,A4)  CCALLSFSUB4(PYWIDT,pywidt,INT,FLOAT,PFLOAT,PFLOAT,A1,A2,A3,A4)

PROTOCCALLSFSUB0(PYXTOT,pyxtot)
#define PYXTOT() CCALLSFSUB0(PYXTOT,pyxtot)

PROTOCCALLSFSUB8(RKBBV,rkbbv,FLOATV,FLOATV,FLOATV,FLOATV,FLOATV,FLOATV,INT,PFLOAT)
#define RKBBV(A1,A2,A3,A4,A5,A6,A7,A8)  CCALLSFSUB8(RKBBV,rkbbv,FLOATV,FLOATV,FLOATV,FLOATV,FLOATV,FLOATV,INT,PFLOAT,A1,A2,A3,A4,A5,A6,A7,A8)

PROTOCCALLSFSUB6(RKHLPK,rkhlpk,INT,PINT,PINT,PINT,PINT,PINT)
#define RKHLPK(A1,A2,A3,A4,A5,A6)  CCALLSFSUB6(RKHLPK,rkhlpk,INT,PINT,PINT,PINT,PINT,PINT,A1,A2,A3,A4,A5,A6)

PROTOCCALLSFSUB2(RLUGET,rluget,INT,INT)
#define RLUGET(A1,A2)  CCALLSFSUB2(RLUGET,rluget,INT,INT,A1,A2)

PROTOCCALLSFSUB2(RLUSET,rluset,INT,INT)
#define RLUSET(A1,A2)  CCALLSFSUB2(RLUSET,rluset,INT,INT,A1,A2)

PROTOCCALLSFSUB11(STRUCTM,structm,DOUBLE,DOUBLE,DOUBLE,DOUBLE,DOUBLE,DOUBLE,DOUBLE,DOUBLE,DOUBLE,DOUBLE,PDOUBLE)
#define STRUCTM(A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11)  CCALLSFSUB11(STRUCTM,structm,DOUBLE,DOUBLE,DOUBLE,DOUBLE,DOUBLE,DOUBLE,DOUBLE,DOUBLE,DOUBLE,DOUBLE,PDOUBLE,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11)

#ifdef __cplusplus
} /* extern "C" */
#endif

#endif /* #ifndef _JETSET74_H */
