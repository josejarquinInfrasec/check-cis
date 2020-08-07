cis_test_name="Audit SUID executables (Not Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -4000 | md5sum)
	[ "$cmd" != "6c5ce88740e397ff4ba13e3ea971285e  -" ] && return 1

	return 0
}