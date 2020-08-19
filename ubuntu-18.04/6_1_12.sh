cis_test_name=" Ensure no ungrouped files or directories exist (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	# Se exceptuan los archivos de systemd, confirmados por el equipo de Cloud
	# https://www.buihanotes.com/2019/05/technical-memo-dynamicuser-in-systemd.html
	# /var/lib/private/systemd/timesync
	# /var/lib/private/systemd/timesync/clock
	cmd=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -nogroup | grep -v "/var/lib/private/systemd")
	[ -n "$cmd" ] && return 1

	return 0
}
