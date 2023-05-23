cis_test_name="Ensure permissions on /etc/motd are configured (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	if [ -e "/etc/motd" ]; then
		cmd=$(stat /etc/motd | grep 'Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)')
		[ -z "$cmd" ] && return 1
	fi
	
	return 0
}
