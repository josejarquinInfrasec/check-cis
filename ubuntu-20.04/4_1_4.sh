cis_test_name="Ensure events that modify user/group information are collected (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=2
cis_test_wpl=2

function cis_test_run()
{
    # -w /etc/group -p wa -k identity
    # -w /etc/passwd -p wa -k identity
    # -w /etc/gshadow -p wa -k identity
    # -w /etc/shadow -p wa -k identity
    # -w /etc/security/opasswd -p wa -k identity
    cmd=$(grep identity /etc/audit/rules.d/*.rules | md5sum)
    [ "$cmd" != "7a688dec39f25df61590759755aecbd5  -" ] && return 1
    # -w /etc/group -p wa -k identity
    # -w /etc/passwd -p wa -k identity
    # -w /etc/gshadow -p wa -k identity
    # -w /etc/shadow -p wa -k identity
    # -w /etc/security/opasswd -p wa -k identity
    cmd=$(auditctl -l | grep identity | md5sum)
    [ "$cmd" != "7a688dec39f25df61590759755aecbd5  -" ] && return 1

    return 0
}