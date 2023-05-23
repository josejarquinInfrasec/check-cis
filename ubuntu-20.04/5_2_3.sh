cis_test_name="Ensure permissions on SSH public host key files are configured (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(find /etc/ssh -xdev -type f -name 'ssh_host_*_key.pub' -exec stat {} \; | grep "Access: (" | grep -v "Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)")
	[ -n "$cmd" ] && return 1

	return 0
}