cis_test_name="Audit SUID executables (Not Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

################################################################
# kvm:
#/bin/fusermount
#/bin/mount
#/bin/ping
#/bin/su
#/bin/umount
#/opt/netdata/bin/fping
#/opt/netdata/usr/libexec/netdata/plugins.d/apps.plugin
#/opt/netdata/usr/libexec/netdata/plugins.d/cgroup-network
#/opt/netdata/usr/libexec/netdata/plugins.d/ioping
#/usr/bin/at
#/usr/bin/chfn
#/usr/bin/chsh
#/usr/bin/gpasswd
#/usr/bin/newgidmap
#/usr/bin/newgrp
#/usr/bin/newuidmap
#/usr/bin/passwd
#/usr/bin/pkexec
#/usr/bin/sudo
#/usr/bin/traceroute6.iputils
#/usr/lib/dbus-1.0/dbus-daemon-launch-helper
#/usr/lib/eject/dmcrypt-get-device
#/usr/lib/openssh/ssh-keysign
#/usr/lib/policykit-1/polkit-agent-helper-1
#/usr/lib/x86_64-linux-gnu/lxc/lxc-user-nic
# physical:
#/bin/fusermount
#/bin/mount
#/bin/ping
#/bin/su
#/bin/umount
#/opt/netdata/bin/fping
#/opt/netdata/usr/libexec/netdata/plugins.d/apps.plugin
#/opt/netdata/usr/libexec/netdata/plugins.d/cgroup-network
#/opt/netdata/usr/libexec/netdata/plugins.d/ioping
#/usr/bin/at
#/usr/bin/chfn
#/usr/bin/chsh
#/usr/bin/gpasswd
#/usr/bin/ksu
#/usr/bin/newgidmap
#/usr/bin/newgrp
#/usr/bin/newuidmap
#/usr/bin/passwd
#/usr/bin/pkexec
#/usr/bin/sudo
#/usr/bin/traceroute6.iputils
#/usr/lib/dbus-1.0/dbus-daemon-launch-helper
#/usr/lib/eject/dmcrypt-get-device
#/usr/lib/openssh/ssh-keysign
#/usr/lib/policykit-1/polkit-agent-helper-1
#/usr/lib/x86_64-linux-gnu/lxc/lxc-user-nic
################################################################

function cis_test_run() {
  cloudiaguest=$(grep -Po '(?<=cloudiaguest:\s)\w+' /etc/puppetlabs/mcollective/generated-facts.yaml)

  if [ "$cloudiaguest" == "kvm" ]; then
    cmd=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -4000 | sort | md5sum)
    [ "$cmd" != "3a6615a968f3e3496cfda768dfb4cb7a  -" ] && return 1
  else
    cmd=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -4000 | sort | md5sum)
    [ "$cmd" != "6f33d6d5215e716971b3199f2948bddd  -" ] && return 1
  fi

  return 0
}
