kernel_module="vfat"
cis_test_name="ensure mounting of ${kernel_module} filesystems is limited"
cis_test_pa=(server workstation)
cis_test_pl=2

function cis_test_run()
{
	# check UEFI
	chk=$(grep '/boot/efi' /etc/fstab)
	if [ -z "$chk" ]; then
		# UEFI disabled
		chk=$(modprobe -n -v ${kernel_module} | grep -v 'crc-itu-t.ko' | grep "^install /bin/true")
		[ -z "$chk" ] && return 1
		chk=$(lsmod | grep ${kernel_module})
		[ -n "$chk" ] && return 1
		return 0
	else
		# UEFI enabled
		chk=$(grep -E -i "\s${kernel_module}\s" /etc/fstab)
		[ -z "$chk" ] && return 1
	fi
}

