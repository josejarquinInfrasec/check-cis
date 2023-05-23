cis_test_name="Ensure cron daemon is enabled (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(systemctl is-enabled cron)
	[ "$cmd" != "enabled" ] && return 1

	return 0
}