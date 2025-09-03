# setup environment for Cernlib - C-shell
#
# Cernlib installation path

# Select imake based build: default is cmake
if ( $?CERNLIB_IMAKE ) then
    if ( "x$CERNLIB_IMAKE" == "x" ) then
	kind="cm"
    else
	kind="im"
    endif
else
    kind="cm"
endif

# Select xrootd build: default is no
if ( $?CERNLIB_XROOTD ) then
    if ( "x$CERNLIB_XROOTD" == "x" ) then
	io="std"
    else
	io="xrd"
    endif
else
    io="std"
endif

# select 64bit build by default
if ( $?CERNLIB_COMPILER ) then
    if ( "x$CERNLIB_COMPILER" == "x" ) then
	comp="gcc"
    else
	comp=$CERNLIB_COMPILER
    endif
else
    comp=$CERNLIB_COMPILER
endif

# Cernlib installation path
if ( $?CERNLIB_TOPDIR ) then
    if ( "x$CERNLIB_TOPDIR" == "x" ) then
	export CERNLIB_TOPDIR=/cvmfs/dphep.cern.ch/cernlib
    else
	echo "Using CERNLIB_TOP_DIR=$CERNLIB_TOP_DIR"
    endif
else
	export CERNLIB_TOPDIR=/cvmfs/dphep.cern.ch/cernlib
endif

# roll back any current settings
source ${CERNLIB_TOPDIR}/unset.csh

if ( $?CERNLIB_INSTALL_DIR ) then
    if ( "x$CERNLIB_INSTALL_DIR" == "x" ) then
	# defined but empty
	setenv CERNLIB_INSTALL_DIR "$CERNLIB_TOPDIR"/releases
    else
	echo "Using CERNLIB_INSTALL_DIR=$CERNLIB_INSTALL_DIR"
    endif
else
    # not defined at all
    setenv CERNLIB_INSTALL_DIR $CERNLIB_TOPDIR
endif

# define Cernlib default version
if ($?CERN_LEVEL) then
    if  ( "x$CERN_LEVEL" == "x" ) then
	setenv CERN_LEVEL "pro"
    endif
else
    setenv CERN_LEVEL "pro"
endif

# guess architecture to be used
if ( -e ${CERNLIB_TOPDIR}/env/osarch)  then
    setenv OS_ARCH `$CERNLIB_TOPDIR/env/osarch`
    setenv OS_TAG `$CERNLIB_TOPRDIR/env/ostag`
else if ( -e env/osarch)  then
    setenv OS_ARCH `env/osarch`
    setenv OS_TAG `env/ostag`
endif

setenv CERN ${CERNLIB_INSTALL_DIR}/${OS_TAG}/$kind/$io/$comp
setenv CERN_ROOT ${CERN}/$CERN_LEVEL
if ( -d ${CERN_ROOT}) then
    setenv CERN_LIBDIR ${CERN_ROOT}/lib
    setenv CERN_BINDIR ${CERN_ROOT}/bin
    setenv CERN_INCLUDE ${CERN_ROOT}/include
    setenv CERN_PAM ${CERN_ROOT}/src/car
    setenv CERN_BIN $CERN_BINDIR
    setenv CERN_LIB $CERN_LIBDIR

    setenv PATH ${CERN_BINDIR}:${PATH}
    if ( $?LD_LIBRARY_PATH ) then
	if ( "x$LD_LIBRARY_PATH" == "x" ) then
	    setenv LD_LIBRARY_PATH ${CERN_LIBDIR}
	else
	    setenv LD_LIBRARY_PATH ${CERN_LIBDIR}:${LD_LIBRARY_PATH}
    else
    	    setenv LD_LIBRARY_PATH ${CERN_LIBDIR}
    endif
else
    echo "This OS (${OS_TAG}) is not supported for version ${CERN_LEVEL}."
    echo 'If you think this is a mistake, please contact us.'
endif
