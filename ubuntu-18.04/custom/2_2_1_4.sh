cis_test_name="Ensure ntp is configured (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(grep -P "^restrict (-4|-6) default kod nomodify notrap nopeer noquery" /etc/ntp.conf | wc -l)
	[ $cmd -ne 2 ] && return 1
	cmd=$(grep -E "^(server|pool) ntp.ubuntu.com" /etc/ntp.conf)
	[ -z "$cmd" ] && return 1
	cmd=$(grep 'RUNASUSER=ntp' /etc/init.d/ntp)
	[ -z "$cmd" ] && return 1
	return 0
}
