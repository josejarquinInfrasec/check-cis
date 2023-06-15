cis_test_name="Ensure DHCP Server is not enabled (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(dpkg -s isc-dhcp-server 2>&1 | grep 'not installed')
	[ -z "$cmd" ] && return 1

	cmd=$(dpkg -s isc-dhcp-server6 2>&1 | grep 'not installed')
	[ -z "$cmd" ] && return 1
	
	return 0
}
