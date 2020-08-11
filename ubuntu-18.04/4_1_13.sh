cis_test_name="Ensure unsuccessful unauthorized file access attempts are collected (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=2
cis_test_wpl=2

function cis_test_run()
{
  # -a always,exit -F arch=b64 -S unlink -S unlinkat -S rename -S renameat -F auid>=500 -F auid!=4294967295 -k delete
  # -a always,exit -F arch=b32 -S unlink -S unlinkat -S rename -S renameat -F auid>=500 -F auid!=4294967295 -k delete
	cmd=$(grep '\-k delete' /etc/audit/rules.d/*.rules | md5sum)
	[ "$cmd" != "abae4d634e0490433a7c187a86e6e65d  -" ] && return 1
  
  # -a always,exit -F arch=b64 -S rename,unlink,unlinkat,renameat -F auid>=500 -F auid!=-1 -F key=delete
  # -a always,exit -F arch=b32 -S unlink,rename,unlinkat,renameat -F auid>=500 -F auid!=-1 -F key=delete
  cmd=$(auditctl -l | grep 'key=delete' | md5sum)
	[ "$cmd" != "421b2f110ed84a2d2de15524d43883da  -" ] && return 1

	return 0
}