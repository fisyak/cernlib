#!/bin/bash -x
#
# idea taken from kojici
#
setup_krb5() {
    out=$1
    cat > "$out" <<EOF
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
    if [[ ! ( -z "${CI_USER}") && ! ( -z "${CI_PASSWD}") ]]; then
	echo "Getting Kerberos token for ${KOJICI_USER}:"
	echo "${CI_PASSWD}" | kinit -f -p "${CI_USER}"@CERN.CH
	RET=$?
	if [[ "$RET" -ne 0 ]]; then
            echo "Error while running kinit"
            exit "$RET"
	fi
    fi
}

# get a ticket to authenticate
setup_krb5 /etc/krb5.conf
run_kinit
klist -f -A

# define cvmfs server
server=cvmfs-dphep.cern.ch
CVMFS_ROOT=/cvmfs/dphep.cern.ch/cernlib

# open a new transaction
ssh -K -oStrictHostKeyChecking=no -oBatchMode=yes "${CI_USER}"@"$server" "sudo -u cvdphep /bin/bash -c \"/bin/cvmfs_server transaction dphep.cern.ch\"" && /bin/false

# copy the tar ball over to CVMFS server
find .
cd cern || exit
for tgz in *-free.tgz; do
    # copy over
    scp -oStrictHostKeyChecking=no -oBatchMode=yes "$tgz" "${CI_USER}"@"${server}":/tmp
    ret=$?
    if [ $ret -eq 0 ]; then
	# unpack
	ssh -K -oStrictHostKeyChecking=no -oBatchMode=yes "${CI_USER}"@"${server}" "sudo -u cvdphep /bin/bash -c \"mkdir -p $CVMFS_ROOT; cd $CVMFS_ROOT && /bin/tar -zxf /tmp/$tgz && cd \""
	# cleanup
	ssh -K -oStrictHostKeyChecking=no -oBatchMode=yes "${CI_USER}"@"${server}" "rm -f /tmp/$tgz"
    fi
done
# close the transaction and deploy
ssh -K -oStrictHostKeyChecking=no -oBatchMode=yes "${CI_USER}"@"${server}" "sudo -u cvdphep /bin/bash -c \"cvmfs_server publish dphep.cern.ch\""
exit "${ret}"

