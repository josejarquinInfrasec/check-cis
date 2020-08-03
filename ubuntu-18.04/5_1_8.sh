cis_test_name="Ensure at/cron is restricted to authorized users (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(stat /etc/cron.deny 2>&1 | grep 'cannot stat')
	[ -z "$cmd" ] && return 1
  cmd=$(stat  /etc/at.deny 2>&1 | grep 'cannot stat')
	[ -z "$cmd" ] && return 1
  cmd=$(stat /etc/cron.allow | grep 'Access: (0640/-rw-r-----)  Uid: (    0/    root)   Gid: (    0/    root)')
	[ -z "$cmd" ] && return 1
	cmd=$(stat /etc/at.allow | grep 'Access: (0640/-rw-r-----)  Uid: (    0/    root)   Gid: (    0/    root)')
	[ -z "$cmd" ] && return 1

	return 0
}