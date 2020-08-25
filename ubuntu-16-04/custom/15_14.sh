cis_test_name="Ensure SSH GatewayPorts is not configured"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(sshd -T | grep "^gatewayports no")
	[ -z "$cmd" ] && return 1

	return 0
}