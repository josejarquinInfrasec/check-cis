cis_test_name="Ensure SSH access is limited (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

######################################################
#  sshd -T | grep -P "^(allowusers|denyusers|allowgroups|denygroups)"
######################################################
# kvm:
#  denyusers ubuntu,root
#  allowgroups cloudadmin
#  allowgroups root
#  allowgroups sudo
#  allowgroups despegar
#  allowgroups munin
#  allowgroups munin-async
#  allowgroups sox
#  denygroups ubuntu
# physical:
#  denyusers ubuntu,root
#  denygroups ubuntu
######################################################

function cis_test_run()
{
	cloudiaguest=$(grep -Po '(?<=cloudiaguest:\s)\w+' /etc/puppetlabs/mcollective/generated-facts.yaml)

	if [ "$cloudiaguest" == "kvm" ]; then
		cmd=$(sshd -T | grep -P "^(allowusers|denyusers|allowgroups|denygroups)" | md5sum)
		[ "$cmd" != "c265a42f7541de28f6b9236f5d73fa96  -" ] && return 1
	else
		cmd=$(sshd -T | grep -P "^(allowusers|denyusers|allowgroups|denygroups)" | md5sum)
		[ "$cmd" != "7605af82284efc47f129c09682becb2d  -" ] && return 1
	fi

	return 0
}