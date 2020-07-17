cis_test_name="Ensure secure ICMP redirects are not accepted (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(sysctl net.ipv4.conf.all.secure_redirects)
	[ "$cmd" != "net.ipv4.conf.all.secure_redirects = 0" ] && return 1
	cmd=$(sysctl net.ipv4.conf.default.secure_redirects)
	[ "$cmd" != "net.ipv4.conf.default.secure_redirects = 0" ] && return 1
	cmd=$(grep "net\.ipv4\.conf\.all\.secure_redirects" /etc/sysctl.conf /etc/sysctl.d/* | grep -v "#" | grep -v "net.ipv4.conf.all.secure_redirects = 0")
	[ -n "$cmd" ] && return 1
	cmd=$(grep "net\.ipv4\.conf\.default\.secure_redirects" /etc/sysctl.conf /etc/sysctl.d/* | grep -v "#" | grep -v "net.ipv4.conf.default.secure_redirects = 0")
	[ -n "$cmd" ] && return 1
	return 0
}
