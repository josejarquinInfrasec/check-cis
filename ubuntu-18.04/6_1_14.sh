cis_test_name="Audit SUID executables (Not Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

#####################################################################################################
#  df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -2000
#####################################################################################################
# kvm:
#/sbin/pam_extrausers_chkpwd
#/sbin/unix_chkpwd
#/usr/bin/at
#/usr/bin/bsd-write
#/usr/bin/chage
#/usr/bin/crontab
#/usr/bin/expiry
#/usr/bin/mlocate
#/usr/bin/mutt_dotlock
#/usr/bin/ssh-agent
#/usr/bin/wall
#/usr/lib/x86_64-linux-gnu/utempter/utempter
#/usr/sbin/postdrop
#/usr/sbin/postqueue
#####################################################################################################

function cis_test_run()
{
	cloudiaguest=$(grep -Po '(?<=cloudiaguest:\s)\w+' /etc/puppetlabs/mcollective/generated-facts.yaml)

	if [ "$cloudiaguest" == "kvm" ]; then
		cmd=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -2000 | sort | md5sum)
		[ "$cmd" != "2bca50da59920b937deb66e7b6aa9f78  -" ] && return 1
	else
		cmd=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -2000 | sort | md5sum)
		[ "$cmd" != "2bca50da59920b937deb66e7b6aa9f78  -" ] && return 1
	fi

	return 0
}