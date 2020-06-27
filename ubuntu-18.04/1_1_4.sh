mount_opt="nosuid"
cis_test_name="ensure ${mount_opt} option set on /tmp partition"
cis_test_pa=(server workstation)
cis_test_pl=1

function cis_test_run()
{
	chk=$(mount | grep -E '\s/tmp\s' | grep -v ${mount_opt})
	[ -n "$chk" ] && return 1
	return 0
}

