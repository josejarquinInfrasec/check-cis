cis_test_name="Ensure no unowned files or directories exist (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	# Se exceptuan los archivos de systemd, confirmados por el equipo de Cloud
	# https://www.buihanotes.com/2019/05/technical-memo-dynamicuser-in-systemd.html
	# /var/lib/private/systemd/timesync
	# /var/lib/private/systemd/timesync/clock
	# Se exceptuan los directorios personales ya que no se eliminan por politica
	# /home/*
	cmd=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -nouser | grep -vP "(/var/lib/private/systemd|/home)")
	[ -n "$cmd" ] && return 1

	return 0
}
