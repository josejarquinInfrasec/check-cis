cis_test_name="Audit SUID executables (Not Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

################################################################
# kvm:
# /bin/ping
# /bin/fusermount
# /bin/su
# /bin/mount
# /bin/umount
# /usr/lib/x86_64-linux-gnu/lxc/lxc-user-nic
# /usr/lib/dbus-1.0/dbus-daemon-launch-helper
# /usr/lib/openssh/ssh-keysign
# /usr/lib/policykit-1/polkit-agent-helper-1
# /usr/lib/eject/dmcrypt-get-device
# /usr/bin/pkexec
# /usr/bin/sudo
# /usr/bin/newgidmap
# /usr/bin/at
# /usr/bin/newgrp
# /usr/bin/gpasswd
# /usr/bin/chsh
# /usr/bin/chfn
# /usr/bin/traceroute6.iputils
# /usr/bin/newuidmap
# /usr/bin/passwd
# /opt/netdata/bin/fping
# /opt/netdata/usr/libexec/netdata/plugins.d/ioping
# /opt/netdata/usr/libexec/netdata/plugins.d/cgroup-network
# /opt/netdata/usr/libexec/netdata/plugins.d/apps.plugi
# physical:
# /usr/lib/openssh/ssh-keysign
# /usr/lib/policykit-1/polkit-agent-helper-1
# /usr/lib/eject/dmcrypt-get-device
# /usr/lib/x86_64-linux-gnu/lxc/lxc-user-nic
# /usr/lib/dbus-1.0/dbus-daemon-launch-helper
# /usr/bin/ksu
# /usr/bin/pkexec
# /usr/bin/chsh
# /usr/bin/newgrp
# /usr/bin/traceroute6.iputils
# /usr/bin/newuidmap
# /usr/bin/passwd
# /usr/bin/gpasswd
# /usr/bin/newgidmap
# /usr/bin/sudo
# /usr/bin/at
# /usr/bin/chfn
# /opt/netdata/usr/libexec/netdata/plugins.d/ioping
# /opt/netdata/usr/libexec/netdata/plugins.d/apps.plugin
# /opt/netdata/usr/libexec/netdata/plugins.d/cgroup-network
# /opt/netdata/bin/fping
# /bin/su
# /bin/mount
# /bin/umount
# /bin/ping
# /bin/fusermount
################################################################

function cis_test_run()
{
	cloudiaguest=$(grep -Po '(?<=cloudiaguest:\s)\w+' /etc/puppetlabs/mcollective/generated-facts.yaml)
	
	if [ "$cloudiaguest" == "kvm" ]; then
		cmd=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -4000 | md5sum)
		[ "$cmd" != "6c5ce88740e397ff4ba13e3ea971285e  -" ] && return 1
	else
		cmd=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -4000 | md5sum)
		[ "$cmd" != "41490c584644f60330e9a26e0e9d6055  -" ] && return 1
	fi
	
	return 0
}