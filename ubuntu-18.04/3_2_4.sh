cis_test_name="Ensure suspicious packets are logged (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(sysctl net.ipv4.conf.all.log_martians)
	[ "$cmd" != "net.ipv4.conf.all.log_martians = 1" ] && return 1
	cmd=$(sysctl net.ipv4.conf.default.log_martians)
	[ "$cmd" != "net.ipv4.conf.default.log_martians = 1" ] && return 1
	cmd=$(grep "net\.ipv4\.conf\.all\.log_martians" /etc/sysctl.conf /etc/sysctl.d/* | grep -v "#" | grep "net.ipv4.conf.all.log_martians = 1")
	[ -n "$cmd" ] && return 1
	cmd=$(grep "net\.ipv4\.conf\.default\.log_martians" /etc/sysctl.conf /etc/sysctl.d/* | grep -v "#" | grep "net.ipv4.conf.default.log_martians = 1")
	[ -n "$cmd" ] && return 1
	return 0
}
