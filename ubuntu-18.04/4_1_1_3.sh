cis_test_name="Ensure auditing for processes that start prior to auditd is enabled (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=2
cis_test_wpl=2

function cis_test_run()
{
	cmd=$(dmesg | grep "Command line" | grep -v 'audit=1')
	[ -n "$cmd" ] && return 1

	return 0
}