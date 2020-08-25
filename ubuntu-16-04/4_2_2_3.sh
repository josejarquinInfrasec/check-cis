cis_test_name="Ensure journald is configured to write logfiles to persistent disk (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
    cmd=$(grep -E -i "^\s*Storage" /etc/systemd/journald.conf | grep "Storage=persistent")
    [ -z "$cmd" ] && return 1

    return 0
}