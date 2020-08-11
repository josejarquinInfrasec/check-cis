cis_test_name="Ensure changes to system administration scope (sudoers) is collected (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=2
cis_test_wpl=2

function cis_test_run() {
  # -w /etc/sudoers -p wa -k scope
  # -w /etc/sudoers.d/ -p wa -k scope
  cmd=$(grep scope /etc/audit/rules.d/*.rules | md5sum)
  [ "$cmd" != "dfc09ca1d9515da55187d906f0332661  -" ] && return 1
  # -w /etc/sudoers -p wa -k scope
  # -w /etc/sudoers.d -p wa -k scope
  cmd=$(auditctl -l | grep scope | md5sum)
  [ "$cmd" != "c50ed1c01b24a67af8afbc59d8b70692  -" ] && return 1

  return 0
}
