cis_test_name="Ensure core dumps are restricted (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(/bin/grep -s -P '^[\s]*\*[\s]+hard[\s]+core[\s]+0[\s]*$' /etc/security/limits.conf /etc/security/limits.d/*)
	[ -z "$cmd" ] && return 1
	cmd=$(/bin/grep -s -P '^[\s]*fs\.suid_dumpable[\s]*=[\s]*0[\s]*$' /etc/sysctl.conf /etc/sysctl.d/*)
	[ -z "$cmd" ] && return 1

	return 0
}
