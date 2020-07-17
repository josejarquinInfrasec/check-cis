cis_test_name="Disable IPv6 (Not Scored)"
cis_test_pa=(server workstation)
cis_test_spl=2
cis_test_wpl=2

function cis_test_run()
{
	cmd=$(dmesg | grep "Command line" | grep -v 'ipv6.disable=1')
	[ -n "$cmd" ] && return 1

	return 0
}