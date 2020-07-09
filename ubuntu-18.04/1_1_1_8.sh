kernel_module="vfat"
cis_test_name="Ensure mounting of ${kernel_module} filesystems is limited (Not Scored)"
cis_test_pa=(server workstation)
cis_test_spl=2
cis_test_wpl=2

function cis_test_run()
{
	# check UEFI
	cmd=$(grep '/boot/efi' /etc/fstab)
	if [ -z "$md" ]; then
		# UEFI disabled
		cmd=$(modprobe -n -v ${kernel_module} | grep -v crc-itu-t)
		[ "$cmd" != "install /bin/true " ] && return 1
		cmd=$(lsmod | grep ${kernel_module})
		[ -n "$cmd" ] && return 1
	else
		# UEFI enabled
		cmd=$(grep -E -i "\s${kernel_module}\s" /etc/fstab)
		[ -z "$cmd" ] && return 1
	fi
	return 0
}

