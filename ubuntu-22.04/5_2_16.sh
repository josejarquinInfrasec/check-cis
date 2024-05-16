cis_test_name="Ensure SSH AllowTcpForwarding is disabled (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=2
cis_test_wpl=2

function cis_test_run()
{
	cmd=$(sshd -T | grep -i "allowtcpforwarding no")
	[ -z "$cmd" ] && return 1

	return 0
}
