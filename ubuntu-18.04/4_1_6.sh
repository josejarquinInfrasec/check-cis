cis_test_name="Ensure events that modify the system Mandatory Access Controls are collected (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=2
cis_test_wpl=2

function cis_test_run()
{
  # -w /etc/apparmor/ -p wa -k MAC-policy
  # -w /etc/apparmor.d/ -p wa -k MAC-policy
	cmd=$(grep MAC-policy /etc/audit/rules.d/*.rules | md5sum)
	[ "$cmd" != "bc6851936ef89fb7c15ece22deda7147  -" ] && return 1

  # -w /etc/apparmor -p wa -k MAC-policy
  # -w /etc/apparmor.d -p wa -k MAC-policy
	cmd=$(auditctl -l | grep MAC | md5sum)
	[ "$cmd" != "13f47e8d2092a8d26865f7607a2da21b  -" ] && return 1

	return 0
}