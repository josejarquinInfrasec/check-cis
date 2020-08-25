cis_test_name="Ensure permissions on /etc/crontab are configured (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(stat /etc/crontab | grep 'Access: (0600/-rw-------)  Uid: (    0/    root)   Gid: (    0/    root)')
	[ -z "$cmd" ] && return 1

	return 0
}