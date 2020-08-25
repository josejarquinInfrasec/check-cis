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
	cmd=$(grep time-change /etc/audit/rules.d/*.rules | md5sum)
	[ "$cmd" != "db6a1675716a6a4b9e9c66adea415cfd  -" ] && return 1
  # -a always,exit -F arch=b64 -S adjtimex,settimeofday -F key=time-change
  # -a always,exit -F arch=b32 -S stime,settimeofday,adjtimex -F key=time-change
  # -a always,exit -F arch=b64 -S clock_settime -F key=time-change
  # -a always,exit -F arch=b32 -S clock_settime -F key=time-change
  # -w /etc/localtime -p wa -k time-change
	cmd=$(auditctl -l | grep time-change | md5sum)
	[ "$cmd" != "3a9d8b0f88e2da89d095dadcff097147  -" ] && return 1

	return 0
}