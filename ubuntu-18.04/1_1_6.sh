partition="/var"
cis_test_name="Ensure separate partition exists for ${partition} (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(mount | grep -E "\s${partition}\s")
	[ -z "$cmd" ] && return 1
	return 0
}

