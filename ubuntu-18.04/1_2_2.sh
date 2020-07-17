cis_test_name="Ensure GPG keys are configured (Not Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(echo)
	[ "$cmd" -ne 4 ] && return 1
	return 0
}

