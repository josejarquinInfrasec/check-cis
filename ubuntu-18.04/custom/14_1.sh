cis_test_name="Ensure root-scripts are disabled"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	root_scripts_path='/usr/local/scripts'
	[ -d $root_scripts_path ] && return 1

	return 0
}