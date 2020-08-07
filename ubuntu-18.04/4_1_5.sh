cis_test_name="Ensure events that modify the system's network environment are collected (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=2
cis_test_wpl=2

function cis_test_run()
{
	cmd=$(grep system-locale /etc/audit/rules.d/*.rules | md5sum)
	[ "$cmd" != "deacf10a883484b740051589471fb976  -" ] && return 1

	cmd=$(auditctl -l | grep system-locale | md5sum)
	[ "$cmd" != "ae393af93504c4c276c6a6e300649ff6  -" ] && return 1

	return 0
}