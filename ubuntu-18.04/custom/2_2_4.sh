package_name="cups"
cis_test_name="Ensure CUPS is not enabled (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(dpkg -s ${package_name} 2>&1 | grep 'not installed')
	[ -z "$cmd" ] && return 1
	return 0
}
