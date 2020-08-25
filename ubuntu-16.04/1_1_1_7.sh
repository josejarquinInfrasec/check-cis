kernel_module="udf"
cis_test_name="Ensure mounting of udf filesystems is disabled (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(modprobe -n -v udf | grep -v crc-itu-t)
	[ "$cmd" != "install /bin/true " ] && return 1

	cmd=$(lsmod | grep udf)
	[ -n "$cmd" ] && return 1
	
	return 0
}

