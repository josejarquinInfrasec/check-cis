cis_test_name="Ensure no world writable files exist (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	# Se execptua JVM de Amazon, el paquete ya incluye archivos con permisos 777 correspondientes a informacion de licencia
	cmd=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -0002 | grep -vP "/usr/lib/jvm/java-\d+-amazon")
	[ -n "$cmd" ] && return 1

	return 0
}
