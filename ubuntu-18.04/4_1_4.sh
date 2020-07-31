cis_test_name="Ensure events that modify user/group information are collected
(Scored)"
cis_test_pa=(server workstation)
cis_test_spl=2
cis_test_wpl=2

function cis_test_run()
{
    cmd=$(grep identity /etc/audit/rules.d/*.rules | md5sum)
    [ "$cmd" != "7a688dec39f25df61590759755aecbd5  -" ] && return 1
    cmd=$(auditctl -l | grep identity | md5sum)
    [ "$cmd" != "7a688dec39f25df61590759755aecbd5  -" ] && return 1

    return 0
}