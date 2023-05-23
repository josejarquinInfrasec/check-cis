cis_test_name="Ensure access to the su command is restricted (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(grep pam_wheel.so /etc/pam.d/su | grep "auth       required   pam_wheel.so use_uid" | grep -v "#")
	[ -z "$cmd" ] && return 1

	return 0
}