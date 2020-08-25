cis_test_name="Ensure default group for the root account is GID 0 (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(grep "^root:" /etc/passwd | cut -f4 -d: | grep 0)
	[ -z "$cmd" ] && return 1

	return 0
}