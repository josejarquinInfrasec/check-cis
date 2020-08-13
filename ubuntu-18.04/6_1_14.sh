cis_test_name="Audit SUID executables (Not Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

#####################################################################################################
#  df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -2000
#####################################################################################################
# kvm:
# /sbin/unix_chkpwd
# /sbin/pam_extrausers_chkpwd
# /usr/lib/x86_64-linux-gnu/utempter/utempter
# /usr/bin/mlocate
# /usr/bin/at
# /usr/bin/expiry
# /usr/bin/mutt_dotlock
# /usr/bin/ssh-agent
# /usr/bin/wall
# /usr/bin/crontab
# /usr/bin/chage
# /usr/bin/bsd-write
# /usr/sbin/postqueue
# /usr/sbin/postdrop
# physical:
# /usr/lib/x86_64-linux-gnu/utempter/utempter
# /usr/bin/crontab
# /usr/bin/bsd-write
# /usr/bin/chage
# /usr/bin/ssh-agent
# /usr/bin/wall
# /usr/bin/mlocate
# /usr/bin/expiry
# /usr/bin/at
# /sbin/pam_extrausers_chkpwd
# /sbin/unix_chkpwd
#####################################################################################################

function cis_test_run()
{
	cloudiaguest=$(grep -Po '(?<=cloudiaguest:\s)\w+' /etc/puppetlabs/mcollective/generated-facts.yaml)

	if [ "$cloudiaguest" == "kvm" ]; then
		cmd=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -2000 | md5sum)
		[ "$cmd" != "826ff09701a75045036aa001115e3790  -" ] && return 1
	else
		cmd=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -2000 | md5sum)
		[ "$cmd" != "2654b703cf4d8120fe03f19fdfa604dc  -" ] && return 1
	fi

	return 0
}