#!/bin/bash -x
#

# guess architecture to be used
ostag=$(find . -name ostag)
if [ -e "$ostag" ]; then
    OS_TAG=$($ostag)
else
    echo "Cannot find ostag script"
    exit 1
fi

if [ "${xrd}" = "" ]; then
    xrd="std"
else
    xrd="xrd"
fi

if [ "${kind}" = "" ]; then
    kind="cm"
elif  [ "${kind}" = "cmake" ]; then
    kind="cm"
elif  [ "${kind}" = "imake" ]; then
    kind="im"
else
    echo "Unknown build type: $kind"
    exit 1
fi

if [ "${comp}" = "" ]; then
    comp="gcc"
fi

target=releases/"${OS_TAG}"/"${kind}"/"${xrd}"/"${comp}"

# create a tar ball
if [ -d cern ]; then
    cd cern || exit
    CERN_VER=$(ls) || exit
    mkdir -p "${target}"
    mv "$CERN_VER" "${target}"
    (cd "${target}"|| exit; ln -sf "${CERN_VER}" new)
    (cd "${target}"|| exit; ln -sf "${CERN_VER}" pro)
    touch "${target}"/"${CERN_VER}"/.cvmfscatalog
    tgz="${OS_TAG}""${kind}""${xrd}""${comp}"_"${CERN_VER}"-free.tgz
    tar -zcf "${tgz}" releases
    rm -rf releases
else
    echo "Cannot find the CERNLIB build"
    exit 1
fi
#
