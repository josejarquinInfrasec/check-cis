cis_test_name="Ensure package manager repositories are configured (Not Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(apt-cache policy | grep -P "500 http://security.ubuntu.com/ubuntu $(lsb_release -cs)-security/(multiverse|universe|restricted|main) amd64 Packages" | wc -l)
	[ "$cmd" -ne 4 ] && return 1
	
	return 0
}

