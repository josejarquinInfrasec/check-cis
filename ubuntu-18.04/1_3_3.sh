cis_test_name="Ensure sudo log file exists (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(grep -Ei '^\s*Defaults\s+logfile=\S+' /etc/sudoers /etc/sudoers.d/*)
	[ -z "$cmd" ] && return 1
	return 0
}

