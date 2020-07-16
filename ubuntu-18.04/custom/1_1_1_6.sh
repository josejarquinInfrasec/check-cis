kernel_module="squashfs"
cis_test_name="Ensure mounting of ${kernel_module} filesystems is disabled (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(grep "install ${kernel_module} /bin/true" /etc/modprobe.d/CIS-${kernel_module}.conf)
	[ -z "$cmd" ] && return 1
	return 0
}

