cis_test_name="Ensure system accounts are secured (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	# Se exceptuan los usuarios munin-async y netdata
	cmd=$(awk -F: '($1!="root" && $1!="sync" && $1!="shutdown" && $1!="halt" && $1!~/^\+/ && $3<'"$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"' && $7!="'"$(which nologin)"'" && $7!="/bin/false") {print}' /etc/passwd | grep -vP '(munin-async|netdata)')
	[ -n "$cmd" ] && return 1

	cmd=$(awk -F: '($1!="root" && $1!~/^\+/ && $3<'"$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"') {print $1}' /etc/passwd | xargs -I '{}' passwd -S '{}' | awk '($2!="L" && $2!="LK") {print $1}')
	[ -n "$cmd" ] && return 1

	return 0
}
