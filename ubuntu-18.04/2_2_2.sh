cis_test_name="Ensure X Window System is not installed (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(dpkg -l xserver-xorg* 2>&1 | grep 'no packages found')
	[ -n "$cmd" ] && return 1
	return 0
}
