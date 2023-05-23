kernel_module="usb-storage"
cis_test_name="Disable USB Storage (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=2

function cis_test_run()
{
	cmd=$(modprobe -n -v ${kernel_module})
	[ "$cmd" != "install /bin/true " ] && return 1

	cmd=$(lsmod | grep ${kernel_module})
	[ -n "$cmd" ] && return 1
	
	return 0
}

