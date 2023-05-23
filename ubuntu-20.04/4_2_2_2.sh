cis_test_name="Ensure journald is configured to compress large log files (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
    cmd=$(grep -E -i "^\s*ForwardToSyslog" /etc/systemd/journald.conf | grep "Compress=yes")
    [ -z "$cmd" ] && return 1

    return 0
}