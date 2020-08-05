cis_test_name="Ensure permissions on /etc/gshadow are configured (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(stat /etc/gshadow | grep "Access: (0640/-rw-r-----)  Uid: (    0/    root)   Gid: (   42/  shadow)")
	[ -z "$cmd" ] && return 1

	return 0
}