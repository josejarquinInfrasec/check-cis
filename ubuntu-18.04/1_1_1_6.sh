kernel_module="squashfs"
cis_test_name="Ensure mounting of ${kernel_module} filesystems is disabled (Scored)"
cis_test_pa=(server workstation)
cis_test_pl=1

function cis_test_run()
{
	chk=$(modprobe -n -v ${kernel_module})
	[ "$cmd" != "install /bin/true " ] && return 1
	chk=$(lsmod | grep ${kernel_module})
	[ -n "$chk" ] && return 1
	return 0
}

