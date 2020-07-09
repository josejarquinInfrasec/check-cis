cis_test_name="Disable Automounting (Scored)"
cis_test_pa=(server workstation)
cis_test_pl=1

function cis_test_run()
{
	cmd=$(systemctl is-enabled autofs)
	[ "$cmd" != "disabled" ] && return 1
	return 0
}

