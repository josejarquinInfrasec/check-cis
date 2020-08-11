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

	# pub   rsa4096 2016-12-27 [SC]
	#       BEE6 8228 9B22 17F4 5AF4  CC3F 901F 9177 AB97 ACBE
	# uid           [ unknown] Treasure Data, Inc (Treasure Agent Official Signing key) <support@treasure-data.com>
	# sub   rsa4096 2016-12-27 [E]

	# pub   rsa4096 2018-01-26 [SCEA]
	#       5921 BC1D 903D 6E03 53C9  85BB 9F89 253B 1E83 EA92
	# uid           [ unknown] https://packagecloud.io/choria/release (https://packagecloud.io/docs#gpg_signing) <support@packagecloud.io>
	# sub   rsa4096 2018-01-26 [SEA]

	# /etc/apt/trusted.gpg.d/puppet5-keyring.gpg
	# ------------------------------------------
	# pub   rsa4096 2013-02-06 [SC] [expired: 2019-02-11]
	#       8735 F5AF 62A9 9A62 8EC1  3377 B8F9 99C0 07BB 6C57
	# uid           [ expired] Puppet Labs Nightly Build Key (Puppet Labs Nightly Build Key) <delivery@puppetlabs.com>
	# uid           [ expired] Puppet Labs Nightly Build Key (Puppet Labs Nightly Build Key) <info@puppetlabs.com>

	# pub   rsa4096 2016-08-18 [SC] [expires: 2021-08-17]
	#       6F6B 1550 9CF8 E59E 6E46  9F32 7F43 8280 EF8D 349F
	# uid           [ unknown] Puppet, Inc. Release Key (Puppet, Inc. Release Key) <release@puppet.com>
	# sub   rsa4096 2016-08-18 [E] [expires: 2021-08-17]

	# pub   rsa4096 2019-04-08 [SC] [expires: 2025-04-06]
	#       D681 1ED3 ADEE B844 1AF5  AA8F 4528 B6CD 9E61 EF26
	# uid           [ unknown] Puppet, Inc. Release Key (Puppet, Inc. Release Key) <release@puppet.com>
	# sub   rsa4096 2019-04-08 [E] [expires: 2025-04-06]

	# /etc/apt/trusted.gpg.d/ubuntu-keyring-2012-archive.gpg
	# ------------------------------------------------------
	# pub   rsa4096 2012-05-11 [SC]
	#       790B C727 7767 219C 42C8  6F93 3B4F E6AC C0B2 1F32
	# uid           [ unknown] Ubuntu Archive Automatic Signing Key (2012) <ftpmaster@ubuntu.com>

	# /etc/apt/trusted.gpg.d/ubuntu-keyring-2012-cdimage.gpg
	# ------------------------------------------------------
	# pub   rsa4096 2012-05-11 [SC]
	#       8439 38DF 228D 22F7 B374  2BC0 D94A A3F0 EFE2 1092
	# uid           [ unknown] Ubuntu CD Image Automatic Signing Key (2012) <cdimage@ubuntu.com>

	# /etc/apt/trusted.gpg.d/ubuntu-keyring-2018-archive.gpg
	# ------------------------------------------------------
	# pub   rsa4096 2018-09-17 [SC]
	#       F6EC B376 2474 EDA9 D21B  7022 8719 20D1 991B C93C
	# uid           [ unknown] Ubuntu Archive Automatic Signing Key (2018) <ftpmaster@ubuntu.com>
	cmd=$(apt-key list 2>&1 | md5sum)
	[ "$cmd" != "4988a10a02e6a8a4ac9b5d6833726e8b  -"  ] && return 1
	
	return 0
}

