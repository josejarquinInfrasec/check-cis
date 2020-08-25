cis_test_name="Ensure auditd service is enabled (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=2
cis_test_wpl=2

function cis_test_run()
{
	cmd=$(systemctl is-enabled auditd)
	[ "$cmd" != "enabled" ] && return 1

	return 0
}