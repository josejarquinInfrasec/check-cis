cis_test_name="Ensure GPG keys are configured (Not Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	# /etc/apt/trusted.gpg
	# --------------------
	# pub   rsa4096 2016-08-01 [SC] [expires: 2027-05-15]
	#       0DCF CA55 47B1 9D2A 6099  5060 96B3 EE5F 2911 1145
	# uid           [ unknown] Wazuh.com (Wazuh Signing Key) <support@wazuh.com>
	# sub   rsa4096 2016-08-01 [E] [expires: 2027-05-15]
	# /etc/apt/trusted.gpg.d/ubuntu-keyring-2018-archive.gpg
	# ------------------------------------------------------
	# pub   rsa4096 2018-09-17 [SC]
	#       F6EC B376 2474 EDA9 D21B  7022 8719 20D1 991B C93C
	# uid           [ unknown] Ubuntu Archive Automatic Signing Key (2018) <ftpmaster@ubuntu.com>
	cmd=$(apt-key list 2>&1 | grep -P "(0DCF CA55 47B1 9D2A 6099  5060 96B3 EE5F 2911 1145|F6EC B376 2474 EDA9 D21B  7022 8719 20D1 991B C93C)" | md5sum)
	[ "$cmd" != "a4f7528f5e5cb5bc9ebe9cac93e5873a  -"  ] && return 1
	
	return 0
}

