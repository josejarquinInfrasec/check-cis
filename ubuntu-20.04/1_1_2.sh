cis_test_name="Ensure /tmp is configured (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(systemctl is-enabled tmp.mount)
	[ "$cmd" != "enabled" ] && return 1

	cmd=$(mount | grep -E '\s/tmp\s')
	[ -z "$cmd" ] && return 1
	
	return 0
}

