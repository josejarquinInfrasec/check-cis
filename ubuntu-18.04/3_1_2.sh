cis_test_name="Ensure IP forwarding is disabled (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(sysctl net.ipv4.ip_forward)
	[ "$cmd" != "net.ipv4.ip_forward = 0" ] && return 1
    
	cmd=$(grep -E -s "^\s*net\.ipv4\.ip_forward\s*=\s*1" /etc/sysctl.conf /etc/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /run/sysctl.d/*.conf)
	[ -z "$cmd" ] && return 1
  
	cmd=$(sysctl net.ipv6.conf.all.forwarding)
	[ "$cmd" != "net.ipv6.conf.all.forwarding = 0" ] && return 1
	
  	cmd=$(grep -E -s "^\s*net\.ipv6\.conf\.all\.forwarding\s*=\s*1" /etc/sysctl.conf /etc/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /run/sysctl.d/*.conf)
	[ -z "$cmd" ] && return 1
	
  	return 0
}
