cis_test_name="Ensure IPv6 router advertisements are not accepted (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
  cmd=$(sysctl net.ipv6.conf.all.accept_ra 2>&1)
    [ "$cmd" != "net.ipv6.conf.all.accept_ra = 0" -a -n "$(echo $cmd | grep -v 'cannot stat')" ] && return 1

  cmd=$(sysctl net.ipv6.conf.default.accept_ra 2>&1)
    [ "$cmd" != "net.ipv6.conf.default.accept_ra = 0" -a -n "$(echo $cmd | grep -v 'cannot stat')" ] && return 1

	cmd=$(grep "net\.ipv6\.conf\.all\.accept_ra" /etc/sysctl.conf /etc/sysctl.d/* | grep -v "#" | grep "net.ipv6.conf.all.accept_ra\s*=\s*0" | wc -l)
	[ $cmd -ne 2 ] && return 1

	cmd=$(grep "net\.ipv6\.conf\.default\.accept_ra" /etc/sysctl.conf /etc/sysctl.d/* | grep -v "#" | grep "net.ipv6.conf.default.accept_ra\s*=\s*0" | wc -l)
	[ $cmd -ne 2 ] && return 1

	return 0
}