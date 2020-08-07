cis_test_name="Audit SUID executables (Not Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -2000 | md5sum)
	[ "$cmd" != "826ff09701a75045036aa001115e3790  -" ] && return 1

	return 0
}