cis_test_name="Ensure Reverse Path Filtering is enabled (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(sysctl net.ipv4.conf.all.rp_filter)
	[ "$cmd" != "net.ipv4.conf.all.rp_filter = 1" ] && return 1

	cmd=$(sysctl net.ipv4.conf.default.rp_filter)
	[ "$cmd" != "net.ipv4.conf.default.rp_filter = 1" ] && return 1

	cmd=$(grep "net\.ipv4\.conf\.all\.rp_filter" /etc/sysctl.conf /etc/sysctl.d/* | grep -v "#" | grep "net.ipv4.conf.all.rp_filter = 1" | wc -l)
	[ $cmd -ne 2 ] && return 1

	cmd=$(grep "net\.ipv4\.conf\.default\.rp_filter" /etc/sysctl.conf /etc/sysctl.d/* | grep -v "#" | grep "net.ipv4.conf.default.rp_filter = 1" | wc -l)
	[ $cmd -ne 2 ] && return 1

	return 0
}