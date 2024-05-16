cis_test_name="Ensure SSH Idle Timeout Interval is configured (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(sshd -T | grep "clientaliveinterval 15")
	[ -z "$cmd" ] && return 1
	cmd=$(sshd -T | grep "clientalivecountmax 3")
	[ -z "$cmd" ] && return 1

	return 0
}
