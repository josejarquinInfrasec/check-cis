cis_test_name="Ensure address space layout randomization (ASLR) is enabled (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(sysctl kernel.randomize_va_space)
	[ "$cmd" != "kernel.randomize_va_space = 2" ] && return 1

	cmd=$(grep "kernel\.randomize_va_space" /etc/sysctl.conf /etc/sysctl.d/* | grep -v 'kernel.randomize_va_space = 2')
	[ -n "$cmd" ] && return 1
	
	return 0
}

