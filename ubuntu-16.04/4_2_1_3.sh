cis_test_name="Ensure logging is configured (Not Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

#########################################################
# /etc/rsyslog.d/50-default.conf						#
#########################################################
# auth,authpriv.*			/var/log/auth.log
# *.*;auth,authpriv.none		-/var/log/syslog
# kern.*				-/var/log/kern.log
# mail.*				-/var/log/mail.log

# mail.err			/var/log/mail.err

# news.crit			/var/log/news/news.crit
# news.err			/var/log/news/news.err
# news.notice			-/var/log/news/news.notice


# *.emerg                                :omusrmsg:*


# daemon.*;mail.*;\
# 	news.err;\
# 	*.=debug;*.=info;\
# 	*.=notice;*.=warn	|/dev/xconsole


function cis_test_run()
{
	cmd=$(grep -v '^#' /etc/rsyslog.d/50-default.conf | md5sum)
	[ "$cmd" != "d4de6e0a468bb7e2b6c00c8c460f0c56  -" ] && return 1

	return 0
}
