cis_test_name="Ensure default user shell timeout is 900 seconds or less (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(grep -E -i "^\s*(\S+\s+)*TMOUT=(900|[1-8][0-9][0-9]|[1-9][0-9]|[1-9])\s*(\S+\s*)*(\s+#.*)?$" /etc/profile /etc/profile.d/*.sh)
	[ -z "$cmd" ] && return 1

	return 0
}