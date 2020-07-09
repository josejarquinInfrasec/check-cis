cis_test_name="ensure /tmp is configured"
cis_test_pa=(server workstation)
cis_test_pl=1

function cis_test_run()
{
	cmd=$(systemctl is-enabled tmp.mount)
	[ "$cmd" != "enabled" ] && return 1
	cmd=$(mount | grep -E '\s/tmp\s')
	[ -z "$cmd" ] && return 1
	return 0
}

