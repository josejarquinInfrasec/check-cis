cis_test_name="Ensure auditd is installed (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=2
cis_test_wpl=2

function cis_test_run()
{
	cmd=$(dpkg -l auditd audisp-plugins 2>&1 | grep "no packages found")
	[ -n "$cmd" ] && return 1
    
  	return 0
}
