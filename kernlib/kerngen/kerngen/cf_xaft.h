/*
* $Id$
*
* $Log$
* Revision 1.2  1999/11/10 17:30:05  mclareni
* Shift version 1.1.4.4 needs POSIX defined on Win32
*
* Revision 1.1.1.1  1996/02/15 17:49:17  mclareni
* Kernlib
*
*
*
* cf#xaft.inc
*/
#if defined(CERNLIB_PROJSHIFT) || defined(CERNLIB_XROOTD)
#if defined(_WIN32)
#define _POSIX_
#endif
#if defined(CERNLIB_PROJSHIFT)
#include <shift.h>
#else
#if defined(XROOTD_BUILDIN_HEADERS)
#include "XrdPosix.hh"
#else
#include <XrdPosix/XrdPosix.hh>
#endif
#endif
#endif

