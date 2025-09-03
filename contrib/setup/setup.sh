#!/bin/bash
# setup environment for Cernlib - Bourne shell
#
   
if [ "$CERNLIB_IMAKE" = "" ]; then
    kind="cm"
else
    kind="im"
fi
if [ "$CERNLIB_XROOTD" = "" ]; then
    io="std"
else
    io="xrd"
fi

if [ "$CERNLIB_COMPILER" = "" ]; then
    comp="gcc"
else
    comp="${CERNLIB_COMPILER}"
fi

# Cernlib installation path
if [ "$CERNLIB_TOPDIR" = "" ]; then
    export CERNLIB_TOPDIR=/cvmfs/dphep.cern.ch/cernlib
fi
# roll back any current settings
. "${CERNLIB_TOPDIR}"/unset.sh

# define Cernlib default version
if [ "${CERN_LEVEL}" = "" ]; then
    CERN_LEVEL="pro"
fi
export CERN_LEVEL

# guess architecture to be used
if [ -e "${CERNLIB_TOPDIR}"/env/osarch ]; then
    OS_ARCH=$("$CERNLIB_TOPDIR"/env/osarch)
    OS_TAG=$("$CERNLIB_TOPDIR"/env/ostag)
else
    if [ -e env/osarch ]; then
        OS_ARCH=$(env/osarch)
        OS_TAG=$(env/ostag)
    fi
fi

if [ "${CERNLIB_INSTALL_DIR}" = "" ]; then
    CERNLIB_INSTALL_DIR="${CERNLIB_TOPDIR}"/releases
fi
export CERNLIB_INSTALL_DIR

CERN="${CERNLIB_INSTALL_DIR}"/"${OS_TAG}"/"${kind}"/"${io}"/"${comp}"
CERN_ROOT="${CERN}"/"${CERN_LEVEL}"
if [ -d "${CERN_ROOT}" ]; then
    CERN_LIBDIR=${CERN_ROOT}/lib
    CERN_BINDIR=${CERN_ROOT}/bin
    CERN_INCLUDE=${CERN_ROOT}/include
    CERN_PAM=${CERN_ROOT}/src/car
    CERN_BIN=$CERN_BINDIR
    CERN_LIB=$CERN_LIBDIR

    PATH=${CERN_BINDIR}:${PATH}
    if [ "$LD_LIBRARY_PATH" = "" ]; then
	LD_LIBRARY_PATH=${CERN_LIBDIR}
    else
	LD_LIBRARY_PATH=${CERN_LIBDIR}:${LD_LIBRARY_PATH}
    fi
    export CERN
    export CERN_ROOT
    export CERN_LIBDIR
    export CERN_BINDIR
    export CERN_INCLUDE
    export CERN_PAM
    export CERN_BIN
    export CERN_LIB
    export PATH
    export LD_LIBRARY_PATH
    export OS_ARCH
    export OS_TAG
else
    echo "This OS (${OS_TAG}) is not supported for version ${CERN_LEVEL}."
    echo 'If you think this is a mistake, please contact us.'
fi
