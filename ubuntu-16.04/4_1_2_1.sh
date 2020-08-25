cis_test_name="Ensure audit log storage size is configured (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=2
cis_test_wpl=2

function cis_test_run()
{
	cmd=$(grep "max_log_file = 5" /etc/audit/auditd.conf)
	[ -z "$cmd" ] && return 1

	return 0
}