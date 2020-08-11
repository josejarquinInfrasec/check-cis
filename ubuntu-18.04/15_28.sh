cis_test_name="Ensure all executed interactive commands are collected"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run() {
  # -a always,exit -F arch=b32 -S execve -F key=audit-wazuh-c
  # -a always,exit -F arch=b64 -S execve -F key=audit-wazuh-c
  cmd=$(grep execve /etc/audit/rules.d/*.rules | md5sum)
  [ "$cmd" != "7015a5493a6628aa416e7320d763a5f1  -" ] && return 1
  # -a always,exit -F arch=b32 -S execve -F key=audit-wazuh-c
  # -a always,exit -F arch=b64 -S execve -F key=audit-wazuh-c
  cmd=$(auditctl -l | grep execve | md5sum)
  [ "$cmd" != "7015a5493a6628aa416e7320d763a5f1  -" ] && return 1

  return 0
}
