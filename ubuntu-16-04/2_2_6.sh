cis_test_name="Ensure LDAP server is not enabled (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(systemctl is-enabled slapd)
	[ "$cmd" != "disabled" ] && return 1
	
	return 0
}
