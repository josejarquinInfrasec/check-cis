cis_test_name="Ensure SSH MaxAuthTries is set to 4 or less"
cis_test_pa=(server workstation)
cis_test_spl=2
cis_test_wpl=2

function cis_test_run()
{
        cmd=$(sshd -T | grep -i "MaxAuthTries 4")
	[ -z "$cmd" ] && return 1

        return 0
}
