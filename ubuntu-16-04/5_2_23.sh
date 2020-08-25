cis_test_name="Ensure SSH MaxSessions is set to 4 or less (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(sshd -T | grep -i "maxsessions 4")
	[ -z "$cmd" ] && return 1

	return 0
}