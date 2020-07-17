cis_test_name="Ensure permissions on bootloader config are configured (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(stat /boot/grub/grub.cfg | grep 'Access: (0400/-r--------)  Uid: (    0/    root)   Gid: (    0/    root)')
	[ -z "$cmd" ] && return 1
	return 0
}

