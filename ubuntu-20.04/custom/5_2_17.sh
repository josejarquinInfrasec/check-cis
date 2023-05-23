cis_test_name="Ensure SSH LoginGraceTime is set to one minute or less (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(sshd -T | grep "logingracetime 60")
	[ -z "$cmd" ] && return 1

	return 0
}