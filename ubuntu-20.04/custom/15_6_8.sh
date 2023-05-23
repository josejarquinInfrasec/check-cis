cis_test_name="Ensure user despegar is not in adm group"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(groups despegar | grep -P "\sadm\s?")
	[ -n "$cmd" ] && return 1

	return 0
}
