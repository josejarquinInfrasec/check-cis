kernel_module="cramfs"
cis_test_name="ensure mounting of ${kernel_module} filesystems is disabled"
cis_test_pa=(server workstation)
cis_test_pl=1

function cis_test_run()
{
	set -e
	chk=$(modprobe -n -v ${kernel_module} | grep -v 'mtd.ko' | grep "^install /bin/true")
	[ -z "$chk" ] && return 1
	chk=$(lsmod | grep ${kernel_module})
	[ -n "$chk" ] && return 1
	return 0
}

