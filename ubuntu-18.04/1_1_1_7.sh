kernel_module="udf"
cis_test_name="Ensure mounting of ${kernel_module} filesystems is disabled (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(modprobe -n -v ${kernel_module} | grep -v crc-itu-t)
	[ "$cmd" != "install /bin/true " ] && return 1
	cmd=$(lsmod | grep ${kernel_module})
	[ -n "$cmd" ] && return 1
	return 0
}

