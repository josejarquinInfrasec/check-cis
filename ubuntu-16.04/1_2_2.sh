cis_test_name="Ensure GPG keys are configured (Not Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	# /etc/apt/trusted.gpg
	# --------------------
	# pub   1024D/437D05B5 2004-09-12
	# uid                  Ubuntu Archive Automatic Signing Key <ftpmaster@ubuntu.com>
	# sub   2048g/79164387 2004-09-12

	# pub   4096R/29111145 2016-08-01 [expires: 2027-05-15]
	# uid                  Wazuh.com (Wazuh Signing Key) <support@wazuh.com>
	# sub   4096R/664FAB32 2016-08-01 [expires: 2027-05-15]
	cmd=$(apt-key list 2>&1 | grep -P "(4096R/29111145|1024D/437D05B5)" | md5sum)
	[ "$cmd" != "a4f7528f5e5cb5bc9ebe9cac93e5873a  -"  ] && return 1
	
	return 0
}

