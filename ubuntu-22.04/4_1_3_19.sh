cis_test_name="Ensure kernel module loading and unloading is collected (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=2
cis_test_wpl=2

function cis_test_run()
{
    # -w /sbin/insmod -p x -k modules
    # -w /sbin/rmmod -p x -k modules
    # -w /sbin/modprobe -p x -k modules
    # -a always,exit -F arch=b64 -S init_module -S delete_module -k modules
    cmd=$(grep modules /etc/audit/rules.d/50-cis-4-1-3-19.rules | md5sum)
    [ "$cmd" != "84b48ca8cebde047d56635671047ee94  -" ] && return 1
    # -w /sbin/insmod -p x -k modules
    # -w /sbin/rmmod -p x -k modules
    # -w /sbin/modprobe -p x -k modules
    # -a always,exit -F arch=b64 -S init_module,delete_module -F key=modules
    cmd=$(auditctl -l | grep modules | md5sum)
    [ "$cmd" != "d41d8cd98f00b204e9800998ecf8427e  -" ] && return 1

    return 0
}
