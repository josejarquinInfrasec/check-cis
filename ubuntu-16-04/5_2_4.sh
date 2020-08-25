cis_test_name="Ensure SSH Protocol is not set to 1 (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(sshd -T | grep -Ei '^\s*protocol\s+(1|1\s*,\s*2|2\s*,\s*1)\s*')
	[ -n "$cmd" ] && return 1

	return 0
}