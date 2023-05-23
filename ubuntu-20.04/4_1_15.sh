cis_test_name="Ensure system administrator actions (sudolog) are collected (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=2
cis_test_wpl=2

function cis_test_run()
{
  # -w /var/log/sudo.log -p wa -k actions
	cmd=$(grep actions /etc/audit/rules.d/*.rules | md5sum)
	[ "$cmd" != "1cae2a1bce415c00c7336f0de83a1a06  -" ] && return 1
  # -w /var/log/sudo.log -p wa -k actions
	cmd=$(auditctl -l | grep actions | md5sum)
	[ "$cmd" != "1cae2a1bce415c00c7336f0de83a1a06  -" ] && return 1

	return 0
}