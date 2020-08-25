cis_test_name="Ensure only strong MAC algorithms are used (Scored)"
cis_test_pa=(server workstation)
cis_test_spl=1
cis_test_wpl=1

function cis_test_run()
{
	cmd=$(sshd -T | grep -i MACs | grep -E "^hmac-md5$|^hmac-md5-96$|^hmac-ripemd160$|^hmac-sha1$|^hmac-sha1-96$|^umac-64@openssh.com$|^umac-128@openssh.com$|^hmac-md5-etm@openssh.com$|^hmac-md5-96-etm@openssh.com$|^hmac-ripemd160-etm@openssh.com$|^hmac-sha1-etm@openssh.com$|^hmac-sha1-96-etm@openssh.com$|^umac-64-etm@openssh.com$|^umac-128-etm@openssh.com$")
	[ -n "$cmd" ] && return 1

	return 0
}