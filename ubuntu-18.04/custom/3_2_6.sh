cis_test_name="Ensure bogus ICMP responses are ignored (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(sysctl net.ipv4.icmp_ignore_bogus_error_responses)
	[ "$cmd" != "net.ipv4.icmp_ignore_bogus_error_responses = 1" ] && return 1

	cmd=$(grep "net.ipv4.icmp_ignore_bogus_error_responses" /etc/sysctl.conf /etc/sysctl.d/* | grep -v "#" | grep "net.ipv4.icmp_ignore_bogus_error_responses\s*=\s*1" | wc -l)
	[ $cmd -ne 2 ] && return 1

	return 0
}