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

create_script() {
    cat > update_release.sh <<EOF
#!/bin/bash

# update deployment links
# This script needs to be run on the CVMFS server
dirs=\$(ls -d /cvmfs/dphep.cern.ch/cernlib/releases/*/*/*/*)
for dir in \$dirs; do
    cd "\$dir" || exit;
    IFS=" " read -a releases <<< \$(find . -maxdepth 1   -type d -not -name '.*' | paste -sd " ")
    new=\$(for r in "\${releases[@]}"; do echo \$r; done | sort -r | head -1 | tail -1 | sed -e 's/\.\///g' )
    pro=\$(for r in "\${releases[@]}"; do echo \$r; done | sort -r | head -2 | tail -1 | sed -e 's/\.\///g')
    old=\$(for r in "\${releases[@]}"; do echo \$r; done | sort -r | head -3 | tail -1 | sed -e 's/\.\///g')
    echo "linking: old=\$old, pro=\$pro, new=\$new for \$dir"
    rm -f old pro new latest
    ln -s \$old old
    ln -s \$pro pro
    ln -s \$new new
    ln -s \$new latest
    for release in "\${releases[@]}"; do
        ls -d \$release/lib > /dev/null 2>&1
        exlit=\$?
        ls -d \$release/lib64 > /dev/null 2>&1
        exlit64="\$?"
        if [ "\$exlit64" -eq 0 -a  "\$exlit" -ne 0  ]; then
            cd \$dir/\$release; ln -s lib64 lib
        fi
    done
done
EOF
    chmod +x update_release.sh
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


# copy the tar ball over to CVMFS server
find .
cd cern || exit
for tgz in *-free.tgz; do
    # copy over
    scp -oStrictHostKeyChecking=no -oBatchMode=yes "$tgz" "${CI_USER}"@"${server}":/tmp
    ret=$?
    if [ $ret -eq 0 ]; then
        # open a new transaction
        ssh -K -oStrictHostKeyChecking=no -oBatchMode=yes "${CI_USER}"@"$server" "sudo -u cvdphep /bin/bash -c \"/bin/cvmfs_server transaction dphep.cern.ch\"" && /bin/false
        # unpack
        ssh -K -oStrictHostKeyChecking=no -oBatchMode=yes "${CI_USER}"@"${server}" "sudo -u cvdphep /bin/bash -c \"cd $CVMFS_ROOT && /bin/tar -zxf /tmp/$tgz && cd \""
        # close the transaction and deploy
        ssh -K -oStrictHostKeyChecking=no -oBatchMode=yes "${CI_USER}"@"${server}" "sudo -u cvdphep /bin/bash -c \"cvmfs_server publish dphep.cern.ch\""
        # cleanup
        ssh -K -oStrictHostKeyChecking=no -oBatchMode=yes "${CI_USER}"@"${server}" "rm -f /tmp/$tgz"
        sleep 5
    fi
done

# create deployment script, send it to cvmfs and run it
create_script
scp -oStrictHostKeyChecking=no -oBatchMode=yes "update_release.sh" "${CI_USER}"@"${server}":/tmp
ssh -K -oStrictHostKeyChecking=no -oBatchMode=yes "${CI_USER}"@"$server" "sudo -u cvdphep /bin/bash -c \"/bin/cvmfs_server transaction dphep.cern.ch\"" && /bin/false
ssh -K -oStrictHostKeyChecking=no -oBatchMode=yes "${CI_USER}"@"${server}" "sudo -u cvdphep /bin/bash -c /tmp/update_release.sh"
ssh -K -oStrictHostKeyChecking=no -oBatchMode=yes "${CI_USER}"@"${server}" "sudo -u cvdphep /bin/bash -c \"cvmfs_server publish dphep.cern.ch\""
ssh -K -oStrictHostKeyChecking=no -oBatchMode=yes "${CI_USER}"@"${server}" "rm -f /tmp/update_release.sh"

exit "${ret}"
