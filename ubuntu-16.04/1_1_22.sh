cis_test_name="Disable Automounting (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=2

function cis_test_run()
{
	cmd=$(systemctl is-enabled autofs)
	[ "$cmd" != "disabled" ] && return 1
	
	return 0
}

