cis_test_name="Ensure events that modify date and time information are collected (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=2
cis_test_wpl=2

function cis_test_run()
{
  # -a always,exit -F arch=b64 -S adjtimex  -S settimeofday -k time-change
  # -a always,exit -F arch=b32 -S adjtimex  -S settimeofday -S stime -k time-change
  # -a always,exit -F arch=b64 -S clock_settime -k time-change
  # -a always,exit -F arch=b32 -S clock_settime -k time-change
  # -w /etc/localtime -p wa -k time-change
	cmd=$(grep time-change /etc/audit/rules.d/50-cis-4-1-3-4.rules | md5sum)
	[ "$cmd" != "223241043826317c39f4a2eaa33badac  -" ] && return 1
  # -a always,exit -F arch=b64 -S adjtimex,settimeofday -F key=time-change
  # -a always,exit -F arch=b32 -S stime,settimeofday,adjtimex -F key=time-change
  # -a always,exit -F arch=b64 -S clock_settime -F key=time-change
  # -a always,exit -F arch=b32 -S clock_settime -F key=time-change
  # -w /etc/localtime -p wa -k time-change
	cmd=$(auditctl -l | grep time-change | md5sum)
	[ "$cmd" != "d41d8cd98f00b204e9800998ecf8427e  -" ] && return 1

	return 0
}
