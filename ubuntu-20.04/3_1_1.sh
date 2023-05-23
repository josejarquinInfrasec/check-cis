cis_test_name="Ensure packet redirect sending is disabled (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(sysctl net.ipv4.conf.all.send_redirects)
	[ "$cmd" != "net.ipv4.conf.all.send_redirects = 0" ] && return 1

	cmd=$(sysctl net.ipv4.conf.default.send_redirects)
	[ "$cmd" != "net.ipv4.conf.default.send_redirects = 0" ] && return 1

	cmd=$(grep -h 'net.ipv4.conf.all.send_redirects' /etc/sysctl.d/* | grep -v '^#' | grep -vP "=\s*0")
	[ -n "$cmd" ] && return 1

	cmd=$(grep -h 'net.ipv4.conf.default.send_redirects' /etc/sysctl.d/* | grep -v '^#' | grep -vP "=\s*0")
	[ -n "$cmd" ] && return 1
	
	return 0
}
