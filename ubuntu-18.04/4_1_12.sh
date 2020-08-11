cis_test_name="Ensure successful file system mounts are collected (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=2
cis_test_wpl=2

function cis_test_run()
{
  # -a always,exit -F arch=b64 -S mount -F auid>=500 -F auid!=4294967295 -k mounts
  # -a always,exit -F arch=b32 -S mount -F auid>=500 -F auid!=4294967295 -k mounts
	cmd=$(grep mounts /etc/audit/rules.d/*.rules | md5sum)
	[ "$cmd" != "bd3856ce21546d056f56414fbe0425db  -" ] && return 1

  # -a always,exit -F arch=b64 -S mount -F auid>=500 -F auid!=-1 -F key=mounts
  # -a always,exit -F arch=b32 -S mount -F auid>=500 -F auid!=-1 -F key=mounts
  cmd=$(auditctl -l | grep mounts | md5sum)
	[ "$cmd" != "6a02f5cb6ebc9f244d8de3405a9c8352  -" ] && return 1

	return 0
}