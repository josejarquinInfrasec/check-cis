cis_test_name=" Ensure /etc/hosts.allow is configured (Not Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(ls /etc/hosts.allow)
	[ "$cmd" != "/etc/hosts.allow" ] && return 1

	return 0
}