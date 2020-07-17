cis_test_name="Ensure all AppArmor Profiles are enforcing (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=2
cis_test_wpl=2

function cis_test_run()
{
	total_profiles=$(apparmor_status | grep profiles | grep -Po '\d+(?=\s+profiles are loaded)')
	enforced_profiles=$(apparmor_status | grep profiles | grep -Po '\d+(?=\s+profiles are in enforce mode)')
	((diff_profiles = total_profiles - enforced_profiles))
	[ $diff_profiles -ne 0 ] && return 1

	unconfined_processes=$(apparmor_status | grep processes | grep -Po '\d+(?=\s+processes are unconfined)')
	[ $unconfined_processes -ne 0 ] && return 1
	
	return 0
}
