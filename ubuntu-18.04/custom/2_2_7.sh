cis_test_name="Ensure NFS and RPC are not enabled (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(systemctl is-enabled nfs-server | grep "Failed to get unit file state for nfs-server.service")
	[ -z "$cmd" ] && return 1
	return 0
}
