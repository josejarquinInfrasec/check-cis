cis_test_name="Ensure source routed packets are not accepted (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(sysctl net.ipv4.conf.all.accept_source_route)
	[ "$cmd" != "net.ipv4.conf.all.accept_source_route = 0" ] && return 0

	cmd=$(sysctl net.ipv4.conf.default.accept_source_route)
	[ "$cmd" != "net.ipv4.conf.default.accept_source_route = 0" ] && return 0

	cmd=$(grep "net\.ipv4\.conf\.all\.accept_source_route" /etc/sysctl.conf /etc/sysctl.d/*)
	[ "$cmd" != "net.ipv4.conf.all.accept_source_route= 0" ] && return 0

	cmd=$(grep "net\.ipv4\.conf\.default\.accept_source_route" /etc/sysctl.conf /etc/sysctl.d/*)
	[ "$cmd" != "net.ipv4.conf.default.accept_source_route= 0" ] && return 0

	cmd=$(sysctl net.ipv6.conf.all.accept_source_route)
	[ "$cmd" != "net.ipv6.conf.all.accept_source_route = 0" ] && return 0

	cmd=$(sysctl net.ipv6.conf.default.accept_source_route)
	[ "$cmd" != "net.ipv6.conf.default.accept_source_route = 0" ] && return 0

	cmd=$(grep "net\.ipv6\.conf\.all\.accept_source_route" /etc/sysctl.conf /etc/sysctl.d/*)
	[ "$cmd" != "net.ipv4.conf.all.accept_source_route= 0" ] && return 0

	cmd=$(grep "net\.ipv6\.conf\.default\.accept_source_route" /etc/sysctl.conf /etc/sysctl.d/*)
	[ "$cmd" != "net.ipv6.conf.default.accept_source_route= 0" ] && return 0
	
	return 0
}
