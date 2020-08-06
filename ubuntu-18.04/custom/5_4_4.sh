cis_test_name="Ensure default user umask is 027 or more restrictive (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(grep -i "UMASK   027" /etc/login.defs)
	[ -z "$cmd" ] && return 1

	return 0
}