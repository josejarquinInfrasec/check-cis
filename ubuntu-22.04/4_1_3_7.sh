cis_test_name="Ensure unsuccessful unauthorized file access attempts are collected (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=2
cis_test_wpl=2

function cis_test_run()
{
  # -a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=500 -F auid!=4294967295 -k access
  # -a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=500 -F auid!=4294967295 -k access
  # -a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=500 -F auid!=4294967295 -k access
  # -a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=500 -F auid!=4294967295 -k access
	cmd=$(grep access /etc/audit/rules.d/*.rules | md5sum)
	[ "$cmd" != "196a22522b2f6ab0fa30d939543bba03  -" ] && return 1

  # -a always,exit -F arch=b64 -S open,truncate,ftruncate,creat,openat -F exit=-EACCES -F auid>=500 -F auid!=-1 -F key=access
  # -a always,exit -F arch=b32 -S open,creat,truncate,ftruncate,openat -F exit=-EACCES -F auid>=500 -F auid!=-1 -F key=access
  # -a always,exit -F arch=b64 -S open,truncate,ftruncate,creat,openat -F exit=-EPERM -F auid>=500 -F auid!=-1 -F key=access
  # -a always,exit -F arch=b32 -S open,creat,truncate,ftruncate,openat -F exit=-EPERM -F auid>=500 -F auid!=-1 -F key=access
  cmd=$(auditctl -l | grep access | md5sum)
	[ "$cmd" != "b08de5c03354b98463fac00db54d2c9e  -" ] && return 1

	return 0
}