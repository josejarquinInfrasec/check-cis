cis_test_name="Ensure updates, patches, and additional security software are installed (Not Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(apt -s dist-upgrade | grep '^Inst' | grep "/$(lsb_release -cs)-security" | wc -l)
	[ $cmd -gt 0 ] && return 1
	
	return 0
}
