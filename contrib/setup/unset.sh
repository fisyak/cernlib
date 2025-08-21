#!/bin/bash
PATH=$(echo "$PATH" | sed -r 's#/cvmfs/dphep.cern.ch/openphigs/[a-zA-Z0-9\/\@_\.\-]*:##g')
LD_LIBRARY_PATH=$(echo "$LD_LIBRARY_PATH" | sed -r 's#/cvmfs/dphep.cern.ch/openphigs/[a-zA-Z0-9\/\@_\.\-]*:##g')
export PATH
export LD_LIBRARY_PATH
unset CERN
unset CERN_ROOT
unset CERN_PAM
unset CERN_LIB
unset CERN_BIN
unset CERN_LIBDIR
unset CERN_BINDIR
unset CERN_INCLUDE
unset CERNLIB_XROOTD
unset CERNLIB_INSTALL_DIR
# do not overwrite user setting to select a different version
if [ "${CERN_LEVEL}" = "pro" ]; then
    unset CERN_LEVEL
fi
