cis_test_name="Ensure session initiation information is collected (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=2
cis_test_wpl=2

function cis_test_run()
{
  # -w /var/run/utmp -p wa -k session
  # -w /var/log/wtmp -p wa -k logins
  # -w /var/log/btmp -p wa -k logins
	cmd=$(grep -E '(session|logins)' /etc/audit/rules.d/*.rules | grep -E "(utmp|wtmp|btmp)" | md5sum)
	[ "$cmd" != "99c42f952dce07185336f47a0084decf  -" ] && return 1
	# -w /var/run/utmp -p wa -k session
  # -w /var/log/wtmp -p wa -k logins
  # -w /var/log/btmp -p wa -k logins
	cmd=$(auditctl -l | grep -E '(session|logins)' | grep -E "(utmp|wtmp|btmp)" | md5sum)
	[ "$cmd" != "99c42f952dce07185336f47a0084decf  -" ] && return 1

	return 0
}