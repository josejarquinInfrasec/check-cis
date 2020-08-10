cis_test_name="Ensure login and logout events are collected (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=2
cis_test_wpl=2

function cis_test_run()
{
  #  -w /var/log/faillog -p wa -k logins
  #  -w /var/log/lastlog -p wa -k logins
  #  -w /var/log/tallylog -p wa -k logins
	cmd=$(grep logins /etc/audit/rules.d/*.rules | md5sum)
	[ "$cmd" != "951b08008f0bb667c2df815aee983db9  -" ] && return 1
  #  -w /var/log/faillog -p wa -k logins
  #  -w /var/log/lastlog -p wa -k logins
  #  -w /var/log/tallylog -p wa -k logins
	cmd=$(auditctl -l | grep logins | md5sum)
	[ "$cmd" != "951b08008f0bb667c2df815aee983db9  -" ] && return 1

	return 0
}