cis_test_name="Ensure discretionary access control permission modification events are collected (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=2
cis_test_wpl=2

function cis_test_run()
{
  # -a always,exit -F arch=b64 -S chmod -S fchmod -S fchmodat -F auid>=500 -F auid!=4294967295 -k perm_mod
  # -a always,exit -F arch=b32 -S chmod -S fchmod -S fchmodat -F auid>=500 -F auid!=4294967295 -k perm_mod
  # -a always,exit -F arch=b64 -S chown -S fchown -S fchownat -S lchown -F auid>=500 -F auid!=4294967295 -k perm_mod
  # -a always,exit -F arch=b32 -S chown -S fchown -S fchownat -S lchown -F auid>=500 -F auid!=4294967295 -k perm_mod
  # -a always,exit -F arch=b64 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=500 -F auid!=4294967295 -k perm_mod
  # -a always,exit -F arch=b32 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=500 -F auid!=4294967295 -k perm_mod
	cmd=$(grep perm_mod /etc/audit/rules.d/*.rules | md5sum)
	[ "$cmd" != "b30ae89f1afec6fffb141441e9956a17  -" ] && return 1
  
  # -a always,exit -F arch=b64 -S chmod,fchmod,fchmodat -F auid>=500 -F auid!=-1 -F key=perm_mod
  # -a always,exit -F arch=b32 -S chmod,fchmod,fchmodat -F auid>=500 -F auid!=-1 -F key=perm_mod
  # -a always,exit -F arch=b64 -S chown,fchown,lchown,fchownat -F auid>=500 -F auid!=-1 -F key=perm_mod
  # -a always,exit -F arch=b32 -S lchown,fchown,chown,fchownat -F auid>=500 -F auid!=-1 -F key=perm_mod
  # -a always,exit -F arch=b64 -S setxattr,lsetxattr,fsetxattr,removexattr,lremovexattr,fremovexattr -F auid>=500 -F auid!=-1 -F key=perm_mod
  # -a always,exit -F arch=b32 -S setxattr,lsetxattr,fsetxattr,removexattr,lremovexattr,fremovexattr -F auid>=500 -F auid!=-1 -F key=perm_mod
  cmd=$(auditctl -l | grep perm_mod | md5sum)
	[ "$cmd" != "d78f8057f7b45d8fe340b13617751b8d  -" ] && return 1

	return 0
}