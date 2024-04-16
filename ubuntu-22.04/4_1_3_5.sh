cis_test_name="Ensure events that modify the system's network environment are collected (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=2
cis_test_wpl=2

function cis_test_run()
{
  #  -a exit,always -F arch=b64 -S sethostname -S setdomainname -k system-locale
  #  -a exit,always -F arch=b32 -S sethostname -S setdomainname -k system-locale
  #  -w /etc/issue -p wa -k system-locale
  #  -w /etc/issue.net -p wa -k system-locale
  #  -w /etc/hosts -p wa -k system-locale
  #  -w /etc/network -p wa -k system-locale
	cmd=$(grep system-locale /etc/audit/rules.d/*.rules | md5sum)
	[ "$cmd" != "deacf10a883484b740051589471fb976  -" ] && return 1
  #  -a always,exit -F arch=b64 -S sethostname,setdomainname -F key=system-locale
  #  -a always,exit -F arch=b32 -S sethostname,setdomainname -F key=system-locale
  #  -w /etc/issue -p wa -k system-locale
  #  -w /etc/issue.net -p wa -k system-locale
  #  -w /etc/hosts -p wa -k system-locale
  #  -w /etc/network -p wa -k system-locale
	cmd=$(auditctl -l | grep system-locale | md5sum)
	[ "$cmd" != "ae393af93504c4c276c6a6e300649ff6  -" ] && return 1

	return 0
}