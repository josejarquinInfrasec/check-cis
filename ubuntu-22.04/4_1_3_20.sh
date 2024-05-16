cis_test_name="Ensure the audit configuration is immutable (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=2
cis_test_wpl=2

function cis_test_run()
{
	cmd=$(grep "^\s*[^#]" /etc/audit/rules.d/99-finalize.rules | tail -1)
	[ "$cmd" != "-e 2" ] && return 1

	return 0
}
