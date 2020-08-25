cis_test_name="Ensure rsync service is not enabled (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(systemctl is-enabled rsync 2>&1)
	[ "$cmd" == "enabled" ] && return 1

	return 0
}