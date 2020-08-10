cis_test_name="Ensure logging is configured (Not Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
  #  auth,authpriv.*			/var/log/auth.log
  #  *.*;auth,authpriv.none		-/var/log/syslog
  #  kern.*				-/var/log/kern.log
  #  mail.*				-/var/log/mail.log
  #  mail.err			/var/log/mail.err
  #  *.emerg				:omusrmsg:*
	cmd=$(grep -v '^#' /etc/rsyslog.d/50-default.conf | md5sum)
	[ "$cmd" != "7359b6ef8f44a6846181976bd7d2c382  -" ] && return 1

	return 0
}
