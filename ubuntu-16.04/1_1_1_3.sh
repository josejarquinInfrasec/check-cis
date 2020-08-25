cis_test_name="Ensure mounting of jffs2 filesystems is disabled (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(modprobe -n -v jffs2 | grep -v mtd)
	[ "$cmd" != "install /bin/true " ] && return 1

	cmd=$(lsmod | grep jffs2)
	[ -n "$cmd" ] && return 1
	
	return 0
}

