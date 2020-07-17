cis_test_name="Ensure SCTP is disabled (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=2
cis_test_wpl=2

function cis_test_run()
{
	cmd=$(modprobe -n -v sctp)
	[ "$cmd" != "install /bin/true " ] && return 1

	return 0
}