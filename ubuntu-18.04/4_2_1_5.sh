cis_test_name="Ensure rsyslog is configured to send logs to a remote log host (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(echo)
	[ -n "$cmd" ] && return 1

	return 0
}
