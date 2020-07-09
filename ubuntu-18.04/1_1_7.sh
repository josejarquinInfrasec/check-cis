partition="/var/tmp"
cis_test_name="ensure separate partition exists for ${partition}"
cis_test_pa=(server workstation)
cis_test_pl=2

function cis_test_run()
{
	cmd=$(mount | grep -E "\s${partition}\s")
	[ -z "$cmd" ] && return 1
	return 0
}

