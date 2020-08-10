cis_test_name="Ensure permissions on /var/log/apt are configured"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(stat /var/log/apt | grep "Access: (0750/drwxr-x---)  Uid: (    0/    root)   Gid: (    0/    root)")
	[ -z "$cmd" ] && return 1

	return 0
}