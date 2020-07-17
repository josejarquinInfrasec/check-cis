cis_test_name="Ensure broadcast ICMP requests are ignored (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(sysctl net.ipv4.icmp_echo_ignore_broadcasts)
	[ "$cmd" != "net.ipv4.icmp_echo_ignore_broadcasts = 1" ] && return 1
	cmd=$(grep "net\.ipv4\.icmp_echo_ignore_broadcasts" /etc/sysctl.conf /etc/sysctl.d/* | grep -v "#" | grep "net.ipv4.icmp_echo_ignore_broadcasts = 1")
	[ -n "$cmd" ] && return 1
	return 0
}
