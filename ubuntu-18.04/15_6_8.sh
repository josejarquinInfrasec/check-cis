cis_test_name="Group despegar in user despegar"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(/usr/bin/groups despegar | grep "despegar : despegar")
	[ -z "$cmd" ] && return 1

	return 0
}