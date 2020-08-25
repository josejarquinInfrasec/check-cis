cis_test_name="Ensure mounting of vfat filesystems is limited (Not Scored)"
cis_test_pa=(server workstation)
cis_test_spl=2
cis_test_wpl=2

function cis_test_run()
{
	# check UEFI
	cmd=$(grep '/boot/efi' /etc/fstab)
	if [ -z "$md" ]; then
		# UEFI disabled
		cmd=$(modprobe -n -v vfat | grep -v crc-itu-t)
		[ "$cmd" != "install /bin/true " ] && return 1
		cmd=$(lsmod | grep vfat)
		[ -n "$cmd" ] && return 1
	else
		# UEFI enabled
		cmd=$(grep -E -i "\svfat\s" /etc/fstab)
		[ -z "$cmd" ] && return 1
	fi
	return 0
}

