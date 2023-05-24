partition="/dev/shm"
mount_option="nosuid"
cis_test_name="Ensure ${mount_option} option set on ${partition} partition (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(mount | grep -E "\s${partition}\s" | grep -v ${mount_option})
	[ -n "$cmd" ] && return 1
	
	return 0
}

