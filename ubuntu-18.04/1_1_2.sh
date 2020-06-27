cis_test_name="ensure /tmp is configured"
cis_test_pa=(server workstation)
cis_test_pl=1

function cis_test_run()
{
	chk=$(systemctl is-enabled tmp.mount)
	[ "$chk" != "enabled" ] && return 1
	chk=$(mount | grep -E '\s/tmp\s')
	[ -z "$chk" ] && return 1
	return 0
}

