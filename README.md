# CIS compliant bash script (check-cis.sh)

**SCRIPT INFORMATION**
---------------------------------------------------------
<pre>
AUTHOR  : Ezequiel Larrarte
DATE    : 2020-06-27
VERSION : 01
</pre>

**DESCRIPTION**
This script runs CIS tests in order to see
if a given server/workstation is CIS compliant.
The script allows you to create your own policy, selecting
only the CIS tests you need. Also, you can log the results
to a file for easy SIEM integration, using KV log format.

**EXAMPLES**
Save all the CIS tests to a policy
check-cis.sh --action list > policy.conf

Edit policy.conf and remove unneeded tests
Execute a CIS test using the policy
check-cis.sh --action execute --cis-policy policy.conf

Execute a specific test
check-cis.sh --action execute --cis-test 1_1_1_1 --verbose
---------------------------------------------------------
