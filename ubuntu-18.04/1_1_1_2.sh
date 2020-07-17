cis_test_name="Ensure mounting of freevxfs filesystems is disabled (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(modprobe -n -v freevxfs)
	[ "$cmd" != "install /bin/true " ] && return 1

	cmd=$(lsmod | grep freevxfs)
	[ -n "$cmd" ] && return 1
	
	return 0
}
