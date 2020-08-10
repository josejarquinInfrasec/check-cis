cis_test_name="Audit SUID executables (Not Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

#####################################################################################################
#  df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -2000
#####################################################################################################
#  /sbin/unix_chkpwd
#  /sbin/pam_extrausers_chkpwd
#  /usr/lib/x86_64-linux-gnu/utempter/utempter
#  /usr/bin/mlocate
#  /usr/bin/at
#  /usr/bin/expiry
#  /usr/bin/mutt_dotlock
#  /usr/bin/ssh-agent
#  /usr/bin/wall
#  /usr/bin/crontab
#  /usr/bin/chage
#  /usr/bin/bsd-write
#  /usr/sbin/postqueue
#  /usr/sbin/postdrop
#####################################################################################################

function cis_test_run()
{
	cmd=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -2000 | md5sum)
	[ "$cmd" != "826ff09701a75045036aa001115e3790  -" ] && return 1

	return 0
}