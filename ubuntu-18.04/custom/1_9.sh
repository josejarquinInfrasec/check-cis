cis_test_name="Ensure updates, patches, and additional security software are installed (Not Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	# Ya que Puppet aplica las actualizaciones en forma progresiva a lo largo de todo el ambiente PCI, antes de ejecutar este test en una instancia, se debe ejecutar:
	# apt update
	# unattended-upgrade -d (el mismo comando que ejecuta Puppet)
	cmd=$(apt -s dist-upgrade 2>&1 | grep '^Inst' | grep "/$(lsb_release -cs)-security" | wc -l)
	[ $cmd -gt 0 ] && return 1
	
	return 0
}
