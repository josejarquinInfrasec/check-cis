cis_test_name=" Ensure no ungrouped files or directories exist (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -nogroup)
	[ -n "$cmd" ] && return 1

	return 0
}