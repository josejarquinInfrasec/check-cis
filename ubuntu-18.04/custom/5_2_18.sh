cis_test_name="Ensure SSH access is limited (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

######################################################
#  sshd -T | grep -P "^(allowusers|denyusers|allowgroups|denygroups)"
######################################################
#  denyusers ubuntu,root
#  allowgroups cloudadmin
#  allowgroups root
#  allowgroups sudo
#  allowgroups despegar
#  allowgroups munin
#  allowgroups munin-async
#  allowgroups sox
#  denygroups ubuntu
######################################################

function cis_test_run()
{
	cmd=$(sshd -T | grep -P "^(allowusers|denyusers|allowgroups|denygroups)" | md5sum)
	[ "$cmd" != "c265a42f7541de28f6b9236f5d73fa96  -" ] && return 1	

	return 0
}