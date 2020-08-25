cis_test_name="Ensure sticky bit is set on all world-writable directories (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	# Se exceptua el directorio utilizado por openstack
	# directorio /run/netns
	cmd=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type d \( -perm -0002 -a ! -perm -1000 \) 2>/dev/null | grep -v "/run/netns")
	[ -n "$cmd" ] && return 1
	
	return 0
}

