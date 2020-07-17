cis_test_name="Ensure rsyslog default file permissions configured (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(grep ^\$FileCreateMode /etc/rsyslog.conf /etc/rsyslog.d/*.conf | grep -v '$FileCreateMode 0640')
	[ -n "$cmd" ] && return 1

	return 0
}
