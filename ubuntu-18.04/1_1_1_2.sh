kernel_module="freevxfs"
cis_test_name="ensure mounting of ${kernel_module} filesystems is disabled"
cis_test_pa=(server workstation)
cis_test_pl=1

function cis_test_run()
{
	cmd=$(modprobe -n -v ${kernel_module})
	[ "$cmd" != "install /bin/true " ] && return 1
	cmd=$(lsmod | grep cramfs)
	[ -n "$cmd" ] && return 1
	return 0
}
