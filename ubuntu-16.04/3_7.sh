cis_test_name="Disable IPv6 (Not Scored)"
cis_test_pa=(server workstation)
cis_test_spl=2
cis_test_wpl=2

function cis_test_run()
{
	if [ -e "/etc/default/grub.d/89-ipv6-disable.cfg" ]; then
		cmd=$(grep "GRUB_CMDLINE_LINUX_DEFAULT=.*ipv6.disable=1.*" /etc/default/grub.d/89-ipv6-disable.cfg)
		[ -z "$cmd" ] && return 1
	fi

	cmd=$(grep -h disable_ipv6 /etc/sysctl.d/* | grep -Po "=\s*1")
	[ -z "$cmd" ] && return 1

	return 0
}