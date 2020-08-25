cis_test_name="Ensure audit_backlog_limit is sufficient (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=2
cis_test_wpl=2

function cis_test_run()
{
	cmd=$(dmesg | grep "Command line" | grep -v "audit_backlog_limit=")
	[ -n "$cmd" ] && return 1

	return 0
}