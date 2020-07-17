cis_test_name="Ensure AppArmor is enabled in the bootloader configuration (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(dmesg | grep "Command line" | grep -v 'apparmor=1')
	[ -n "$cmd" ] && return 1
	cmd=$(dmesg | grep "Command line" | grep -v 'security=apparmor')
	[ -n "$cmd" ] && return 1
	return 0
}
