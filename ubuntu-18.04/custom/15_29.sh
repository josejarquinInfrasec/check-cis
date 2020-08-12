cis_test_name="Ensure HIDS is configured"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
  host_ip=$(ifconfig ens3 | grep -Po '(?<=inet\s)[\.\d]+')
  cmd=$(grep -P "^\d+\s[\w\-]+\s${host_ip}\s.{64}" /var/ossec/etc/client.keys)
  [ -z "$cmd" ] && return 1

  cmd=$(cat /var/ossec/etc/shared/agent.conf | md5sum)
  [ "$cmd" != "eef3cc10a70e78d68a505f0a380504df  -" ] && return 1

  return 0
}
