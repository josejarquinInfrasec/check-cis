cis_test_name="Ensure HIDS is configured"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
  if [[ "$(hostname)" != "soc-wazuh-mg-"* ]]; then
    #cloudiaguest=$(grep -Po '(?<=cloudiaguest:\s)\w+' /etc/puppetlabs/mcollective/generated-facts.yaml)
    cloudiaguest=$(facter -p cloudiaguest)

    if [ "$cloudiaguest" == "kvm" ]; then
      host_ip=$(ifconfig ens3 | grep -Po '(?<=inet\s)[\.\d]+')
      cmd=$(grep -P "^\d+\s$(hostname)\s${host_ip}\s.{64}" /var/ossec/etc/client.keys)
      [ -z "$cmd" ] && return 1

      cmd=$(cat /var/ossec/etc/shared/agent.conf | md5sum)
      [ "$cmd" != "eef3cc10a70e78d68a505f0a380504df  -" ] && return 1
    else
      host_ip=$(ifconfig bond0 | grep -Po '(?<=inet\s)[\.\d]+')
      cmd=$(grep -P "^\d+\s$(hostname)\s${host_ip}\s.{64}" /var/ossec/etc/client.keys)
      [ -z "$cmd" ] && return 1

      cmd=$(cat /var/ossec/etc/shared/agent.conf | md5sum)
      [ "$cmd" != "7f4402caf577bcd20949e3c5226611ab  -" ] && return 1
    fi
  fi

  return 0
}
