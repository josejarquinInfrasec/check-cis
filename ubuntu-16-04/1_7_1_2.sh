cis_test_name="Ensure AppArmor is enabled in the bootloader configuration (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(grep "^\s*linux" /boot/grub/grub.cfg | grep -v "apparmor=1" | grep -v '/boot/memtest86+.bin')
	[ -n "$cmd" ] && return 1

	cmd=$(grep "^\s*linux" /boot/grub/grub.cfg | grep -v "security=apparmor" | grep -v '/boot/memtest86+.bin')
	[ -n "$cmd" ] && return 1

	return 0
}
