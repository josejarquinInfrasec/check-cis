cis_test_name="Ensure no world writable files exist (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	# Se exceptua JVM de Amazon, el paquete ya incluye archivos con permisos 777 correspondientes a informacion de licencia
	# /usr/lib/jvm-XX-amazon
	# Se exceptuan los archivos generado por fluentd
	# /tmp/sigdump-X.log
	cmd=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -0002 | grep -vP "(/usr/lib/jvm/java-\d+-amazon|/tmp/sigdump-\d+.log)")
	[ -n "$cmd" ] && return 1

	return 0
}
