cis_test_name="Ensure no unowned files or directories exist (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	# Se exceptuan los archivos de systemd, confirmados por el equipo de Cloud
	cmd=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -nouser | grep -v "/var/lib/private/systemd")
	[ -n "$cmd" ] && return 1

	return 0
}
