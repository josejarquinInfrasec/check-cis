cis_test_name="Ensure rsh client is not installed (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(dpkg -s rsh-client | grep -i "status: install ok installed")
	[ -z "$cmd" ] && return 1

	return 0
}