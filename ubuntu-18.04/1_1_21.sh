cis_test_name="Ensure sticky bit is set on all world-writable directories (Scored)"
cis_test_pa=(server workstation)
cis_test_pl=1

function cis_test_run()
{
	cmd=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type d \( -perm -0002 -a ! -perm -1000 \) 2>/dev/null)
	[ -n "$cmd" ] && return 1
	return 0
}

