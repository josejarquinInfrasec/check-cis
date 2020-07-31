cis_test_name="Ensure mail transfer agent is configured for local-only mode (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(ss -lntu | grep -E ':25\s' | grep -E -v '\s(127.0.0.1|::1):25\s')
	[ -n "$cmd" ] && return 1

	return 0
}
