cis_test_name="Audit SUID executables (Not Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

################################################################
#  /bin/ping
#  /bin/fusermount
#  /bin/su
#  /bin/mount
#  /bin/umount
#  /usr/lib/x86_64-linux-gnu/lxc/lxc-user-nic
#  /usr/lib/dbus-1.0/dbus-daemon-launch-helper
#  /usr/lib/openssh/ssh-keysign
#  /usr/lib/policykit-1/polkit-agent-helper-1
#  /usr/lib/eject/dmcrypt-get-device
#  /usr/bin/pkexec
#  /usr/bin/sudo
#  /usr/bin/newgidmap
#  /usr/bin/at
#  /usr/bin/newgrp
#  /usr/bin/gpasswd
#  /usr/bin/chsh
#  /usr/bin/chfn
#  /usr/bin/traceroute6.iputils
#  /usr/bin/newuidmap
#  /usr/bin/passwd
#  /opt/netdata/bin/fping
#  /opt/netdata/usr/libexec/netdata/plugins.d/ioping
#  /opt/netdata/usr/libexec/netdata/plugins.d/cgroup-network
#  /opt/netdata/usr/libexec/netdata/plugins.d/apps.plugin
################################################################

function cis_test_run()
{
	cmd=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -4000 | md5sum)
	[ "$cmd" != "6c5ce88740e397ff4ba13e3ea971285e  -" ] && return 1

	return 0
}