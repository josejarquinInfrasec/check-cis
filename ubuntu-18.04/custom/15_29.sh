cis_test_name="Ensure HIDS is configured"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
  if [[ "$(hostname)" != "soc-wazuh-mg-"* ]]; then
    #cloudiaguest=$(grep -Po '(?<=cloudiaguest:\s)\w+' /etc/puppetlabs/mcollective/generated-facts.yaml)
    cloudiaguest=$(facter -p cloudiaguest)
    environment=$(facter -p environment)
    environment_name=$(echo $environment | grep -Po "^(pci|prod)")
    environment_openstack=$(echo $environment | grep -Po "(mitaka|queens)$")

    case "$environment_name" in
      pci)
        if [ "$cloudiaguest" == "kvm" ]; then
          host_ip=$(ip address show ens3 | grep -Po '(?<=inet\s)[\.\d]+')
          cmd=$(grep -P "^\d+\s$(hostname)\s${host_ip}\s.{64}" /var/ossec/etc/client.keys)
          [ -z "$cmd" ] && return 1

          cmd=$(cat /var/ossec/etc/shared/agent.conf | md5sum)
          [ "$cmd" != "b1aee6d37f18e6955d8936425a09620a  -" ] && return 1
        else
          host_ip=$(ip address show bond0 | grep -Po '(?<=inet\s)[\.\d]+')
          cmd=$(grep -P "^\d+\s$(hostname)\s${host_ip}\s.{64}" /var/ossec/etc/client.keys)
          [ -z "$cmd" ] && return 1

          cmd=$(cat /var/ossec/etc/shared/agent.conf | md5sum)
          [ "$cmd" != "7f4402caf577bcd20949e3c5226611ab  -" ] && return 1
        fi
      ;;

      prod)
        if [ "$cloudiaguest" == "kvm" ]; then
          if [ "$environment_openstack" == "queens" ]; then
            host_ip=$(ip address show ens3 | grep -Po '(?<=inet\s)[\.\d]+')
            cmd=$(grep -P "^\d+\s$(hostname)\s${host_ip}\s.{64}" /var/ossec/etc/client.keys)
            [ -z "$cmd" ] && return 1
          fi

          cmd=$(cat /var/ossec/etc/shared/agent.conf | md5sum)
          [ "$cmd" != "9eb74877895a5d982dfbe825651b7a91  -" ] && return 1
        fi
      ;;
    esac
  fi

  return 0
}
