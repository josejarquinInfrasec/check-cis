cis_test_name="Ensure permissions on certain log files are configured"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(stat /var/log/puppetlabs/mcollective/mcollective.log | grep 'Access: (0640/-rw-r-----)  Uid: (    0/    root)   Gid: (    0/    root)')
	[ -z "$cmd" ] && return 1

	cmd=$(stat /var/log/cloud-init.log | grep 'Access: (0640/-rw-r-----)  Uid: (    0/    root)   Gid: (    0/    root)')
	[ -z "$cmd" ] && return 1

	cmd=$(stat /var/log/apt/history.log | grep 'Access: (0640/-rw-r-----)  Uid: (    0/    root)   Gid: (    0/    root)')
	[ -z "$cmd" ] && return 1

	cmd=$(stat /var/log/munin/munin-node.log | grep 'Access: (0640/-rw-r-----)  Uid: (    0/    root)   Gid: (    0/    root)')
	[ -z "$cmd" ] && return 1

	cmd=$(stat /var/log/dpkg.log | grep 'Access: (0640/-rw-r-----)  Uid: (    0/    root)   Gid: (    0/    root)')
	[ -z "$cmd" ] && return 1

	return 0
}