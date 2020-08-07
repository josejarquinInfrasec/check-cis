cis_test_name="Ensure only strong Key Exchange algorithms are used (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(sshd -T | grep kexalgorithms | grep -P "(diffie-hellman-group1-sha1|diffie-hellman-group14-sha1|diffie-hellman-group-exchange-sha1)")
	[ -n "$cmd" ] && return 1

	return 0
}