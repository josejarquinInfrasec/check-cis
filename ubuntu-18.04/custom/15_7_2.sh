cis_test_name="Ensure permissions on /home/despegar are configured"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(stat /home/despegar | grep "Access: (2755/drwxr-sr-x)  Uid: ( 1001/despegar)   Gid: ( 1001/despegar)")
	[ -z "$cmd" ] && return 1

	return 0
}