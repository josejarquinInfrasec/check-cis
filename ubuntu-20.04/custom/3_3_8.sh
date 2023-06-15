cis_test_name="Ensure TCP SYN Cookies is enabled (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(sysctl net.ipv4.tcp_syncookies)
	[ "$cmd" != "net.ipv4.tcp_syncookies = 1" ] && return 1

	cmd=$(grep "net\.ipv4\.tcp_syncookies" /etc/sysctl.conf /etc/sysctl.d/* | grep -v "#" | grep -v "net.ipv4.tcp_syncookies\s*=\s*1")
	[ -n "$cmd" ] && return 1

	return 0
}
