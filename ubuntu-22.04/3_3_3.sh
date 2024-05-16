cis_test_name="Ensure secure ICMP redirects are not accepted (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(/bin/grep -s -P '^[\s]*net\.ipv4\.conf\.all\.secure_redirects[\s]*=[\s]*0[\s]*$' /etc/sysctl.conf /etc/sysctl.d/*)
	[ -z "$cmd" ] && return 1
	cmd=$(/bin/grep -s -P '^[\s]*net\.ipv4\.conf\.default\.secure_redirects[\s]*=[\s]*0[\s]*$' /etc/sysctl.conf /etc/sysctl.d/*)
	[ -z "$cmd" ] && return 1

	return 0
}
