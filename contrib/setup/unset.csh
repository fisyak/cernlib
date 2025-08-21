setenv PATH `echo $PATH | sed -r 's#/cvmfs/dphep.cern.ch/cernlib/[a-zA-Z0-9\/\@_\.\-]*:##g'`
setenv LD_LIBRARY_PATH `echo $LD_LIBRARY_PATH | sed -r 's#/cvmfs/dphep.cern.ch/cernlib/[a-zA-Z0-9\/\@_\.\-]*:##g'`
unsetenv CERN
unsetenv CERN_ROOT
unsetenv CERN_PAM
unsetenv CERN_LIB
unsetenv CERN_BIN
unsetenv CERN_INCLUDE
unsetenv CERNLIB_XROOTD
unsetenv CERNLIB_INSTALL_DIR

if ( $?CERN_LEVEL ) then
    if ( "x$CERN_LEVEL" == "xpro" ) then
	unsetenv CERN_LEVEL
    endif
endif
