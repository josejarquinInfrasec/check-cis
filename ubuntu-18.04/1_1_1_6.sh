cis_test_name="Ensure mounting of squashfs filesystems is disabled (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	chk=$(modprobe -n -v squashfs)
	[ "$cmd" != "install /bin/true " ] && return 1
	chk=$(lsmod | grep squashfs)
	[ -n "$chk" ] && return 1
	return 0
}

