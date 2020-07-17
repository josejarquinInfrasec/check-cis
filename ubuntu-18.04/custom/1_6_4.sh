cis_test_name="Ensure core dumps are restricted (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(grep 'hard core' /etc/security/limits.conf /etc/security/limits.d/* | grep -vP '(root|\*) hard core 0')
	[ -n "$cmd" ] && return 1

	cmd=$(sysctl fs.suid_dumpable)
	[ -z "$cmd" != "fs.suid_dumpable = 0" ] && return 1

	cmd=$(grep "fs\.suid_dumpable" /etc/sysctl.conf /etc/sysctl.d/* | grep -v 'fs.suid_dumpable = 0')
	[ -n "$cmd" ] && return 1
	
	return 0
}
