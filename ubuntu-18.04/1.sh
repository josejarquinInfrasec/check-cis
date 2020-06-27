kernel_module="cramfs"
cis_test_name="1_1_1_1-ensure mounting of ${kernel_module} filesystems is disabled"
cis_test_pa=(server workstation)
cis_test_pl=1

function cis_test_run()
{
	set -e
	chk=$(modprobe -n -v ${kernel_module} | grep -v 'mtd.ko' | grep "^install /bin/true")
	[ -z "$chk" ] && return ${EXIT_FAILURE}
	chk=$(lsmod | grep ${kernel_module})
	[ -n "$chk" ] && return ${EXIT_FAILURE}
	return ${EXIT_SUCCESS}
}

