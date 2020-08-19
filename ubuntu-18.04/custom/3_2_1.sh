cis_test_name="Ensure source routed packets are not accepted (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(sysctl net.ipv4.conf.all.accept_source_route)
	[ "$cmd" != "net.ipv4.conf.all.accept_source_route = 0" ] && return 1

	cmd=$(sysctl net.ipv4.conf.default.accept_source_route)
	[ "$cmd" != "net.ipv4.conf.default.accept_source_route = 0" ] && return 1

	cmd=$(grep -h 'net.ipv4.conf.all.accept_source_route' /etc/sysctl.d/* | grep -v '^#' | grep -vP "=\s*0")
	[ -n "$cmd" ] && return 1

	cmd=$(grep -h 'net.ipv4.conf.default.accept_source_route' /etc/sysctl.d/* | grep -v '^#' | grep -vP "=\s*0")
	[ -n "$cmd" ] && return 1

	cmd=$(sysctl net.ipv6.conf.all.accept_source_route 2>&1)
	[ "$cmd" != "net.ipv6.conf.default.accept_source_route = 0" -a -n "$(echo $cmd | grep -v 'cannot stat')" ] && return 1
	
	cmd=$(sysctl net.ipv6.conf.default.accept_source_route 2>&1)
	[ "$cmd" != "net.ipv6.conf.default.accept_source_route = 0" -a -n "$(echo $cmd | grep -v 'cannot stat')" ] && return 1

	cmd=$(grep -h 'net.ipv6.conf.all.accept_source_route' /etc/sysctl.d/* | grep -v '^#' | grep -vP "=\s*0")
	[ -n "$cmd" ] && return 1
	
	cmd=$(grep -h 'net.ipv6.conf.default.accept_source_route' /etc/sysctl.d/* | grep -v '^#' | grep -vP "=\s*0")
	[ -n "$cmd" ] && return 1
	return 0
}