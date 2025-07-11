#!/bin/bash -x
#

get_ostag(){
    kind=$1
    if [ -e /etc/os-release ]; then
	export OS_ID=$(grep -oP '(?<=^ID=).+' /etc/os-release | tr -d '"')
	export OS_RELEASE=$(grep -oP '(?<=^VERSION_ID=).+' /etc/os-release | tr -d '"'| cut -d\. -f1)
    else
	export OS_ID=`lsb_release -is`
	export OS_RELEASE=`lsb_release -rs|cut -d\. -f1`
    fi
    OS_ARCH=`uname -m`
    if [ "x$OS_ARCH" = "xx86_64" -a "x$LEGACY" != "x" ]; then OS_ARCH='i386'; fi
    export OS_ARCH
    export OS_TAG=`echo ${OS_ID}-${OS_ARCH}-${OS_RELEASE}|tr '[:upper:]' '[:lower:]'`_${kind}
}

# get a ticket to authenticate
echo $CI_USER

# get the ostag to identify the build
get_ostag $kind
CERN_VER="unknown"
# check what we have
if [ -d cern ]; then
    cd cern
    files=`ls`
    mkdir $OS_TAG
    for dir in $files; do
	CERN_VER=$dir
	mv $dir $OS_TAG/
    done
else
    echo "Cannot find the CERNLIB build"
    exit 1
fi
#
pwd
# create a tar ball
tgz=${OS_TAG}_${CERN_VER}-free.tgz
tar -zcf ${tgz} $OS_TAG
rm -rf $OS_TAG
