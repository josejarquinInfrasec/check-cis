# CIS compliant bash script (check-cis.sh)

**SCRIPT INFORMATION**
---------------------------------------------------------
<pre>
AUTHOR  : Ezequiel Larrarte
DATE    : 2020-06-27
VERSION : 01
</pre>

**DESCRIPTION**
---------------------------------------------------------
<pre>
This script runs CIS tests in order to see
if a given Linux server/workstation is CIS compliant.
The script allows you to create your own policy, selecting
only the CIS tests you need. Also, you can log the results
to a file for easy SIEM integration, using KV log format.
The script can be easily extendend adding the unitary tests
for a specific Linux distribution. At the time of writing, only
Ubuntu 18.04 CIS 2.0.1 is supported (work in progress).
</pre>

**EXAMPLES**
---------------------------------------------------------
<pre>
Save all the CIS tests to a policy
check-cis.sh --action list > policy.conf

Edit policy.conf and remove unneeded tests
Execute a CIS test using the policy
check-cis.sh --action execute --cis-policy policy.conf

Execute those tests with workstation applicability from the policy
check-cis.sh --action execute --cis-policy policy.conf --cis-pa workstation

Execute those tests with profile level 1 from the policy
check-cis.sh --action execute --cis-policy policy.conf --cis-pl 1

Execute a specific test
check-cis.sh --action execute --cis-test 1_1_1_1 --verbose
</pre>

