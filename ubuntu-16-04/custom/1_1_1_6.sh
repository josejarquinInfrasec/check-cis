cis_test_name="Ensure mounting of squashfs filesystems is disabled (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(grep "install squashfs /bin/true" /etc/modprobe.d/CIS-squashfs.conf)
	[ -z "$cmd" ] && return 1
	
	return 0
}

