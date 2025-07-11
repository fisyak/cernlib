#!/bin/bash -x
#
# idea taken from kojici
#
setup_krb5() {
    out=$1
    cat > $out <<EOF
[libdefaults]
 default_realm = CERN.CH
 ticket_lifetime = 25h
 renew_lifetime = 120h
 forwardable = true 
 proxiable = true
 default_tkt_enctypes = aes256-cts aes128-cts
 chpw_prompt = true
 rdns = false

[domain_realm]
.cern.ch = CERN.CH

[realms]
CERN.CH = {
  default_domain = cern.ch
  kpasswd_server = cerndc.cern.ch
  admin_server = cerndc.cern.ch
  kdc = cerndc.cern.ch
}
EOF

}

run_kinit() {
    if [[ !( -z "${CI_USER}") && !( -z "${CI_PASSWD}") ]]; then
	echo "Getting Kerberos token for ${KOJICI_USER}:"
	echo "${CI_PASSWD}" | kinit -f -p ${CI_USER}@CERN.CH
	RET=$?
	if [[ $RET -ne 0 ]]; then
            echo "Error while running kinit"
            exit $RET
	fi
    fi
}

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
setup_krb5 /etc/krb5.conf
run_kinit
klist -f -A

# define target and copy over
initial=`echo $CI_USER|cut -c1`
eosdir=/eos/user/${initial}/${CI_USER}/cernlib/
# Select a node from lxplus9
ip=`host lxplus.cern.ch | head -1 | awk '{print $4}'`
selected=`host $ip | awk '{print $5}'|cut -d \. -f1`

# copy to EOS via lxplus
ssh -K -oStrictHostKeyChecking=no -oBatchMode=yes ${CI_USER}@$selected "rm -rf /tmp/x${CI_USER};mkdir /tmp/x${CI_USER}"
scp -v -v -oStrictHostKeyChecking=no -oBatchMode=yes cern/*.tgz ${CI_USER}@$selected:/tmp/x${CI_USER}/
ssh -K -oStrictHostKeyChecking=no -oBatchMode=yes ${CI_USER}@$selected "/usr/bin/eosfusebind; mv /tmp/x${CI_USER}/*.tgz $eosdir"
