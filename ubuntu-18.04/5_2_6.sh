cis_test_name="Ensure SSH X11 forwarding is disabled (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=2
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(sshd -T | grep "x11forwarding no")
	[ -z "$cmd" ] && return 1

	return 0
}