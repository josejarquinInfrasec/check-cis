cis_test_name="Ensure SSH X11 forwarding is disabled (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(grep -Ei '^\s*x11forwarding\s+no' /etc/ssh/sshd_config)
	[ -z "$cmd" ] && return 1

	return 0
}
