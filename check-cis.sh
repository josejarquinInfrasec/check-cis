#!/bin/bash

# SCRIPT INFORMATION
# ---------------------------------------------------------
# AUTHOR  : Ezequiel Larrarte
# DATE    : 2020-06-27
# VERSION : 01
#
# DESCRIPTION
# This script runs CIS tests in order to see
# if a given server/workstation is CIS compliance.
# The script allows you to create your own policy, selecting
# only the CIS tests you need. Also, you can log the results
# to a file for easy SIEM integration.
# ---------------------------------------------------------


# CONFIGURATION
# ---------------------------------------------------------
# script name
script_name="check-cis"
# default log file
def_log_file="/var/log/${script_name}.log"
# default CIS profile applicability (server|workstation)
def_cis_pa="server"
# default CIS profile level (1|2)
def_cis_pl=2
# ---------------------------------------------------------


# FUNCTIONS
# ---------------------------------------------------------
# POSIX exit codes
EXIT_SUCCESS=0
EXIT_FAILURE=1

# Boolean values
FALSE=0
TRUE=1

function help()
{
    echo
    echo "HELP"
    echo "${script_name}.sh -h|--help"
    echo "${script_name}.sh --action action [options]"
    echo
    echo "ACTIONS"
    echo "list                          List CIS tests"
    echo "execute                       Execute CIS tests"
    echo
    echo "OPTIONS"
    echo "--cis-pa      applicability   Set CIS profile applicability (server|workstation)"
    echo "--cis-pl      level           Set CIS profile level (1|2)"
    echo "--cis-policy  file            Set CIS policy file to use"
    echo "--cis-test    test-id         Execute a specific test (action:execute required)"
    echo "--verbose                     Show verbose output (action:execute required)"
    echo "--only-fail                   Show only failed tests"
    echo
    exit ${EXIT_SUCCESS}
}

function process_cli_opts()
{
    cli_opts=$(getopt -o ha: -l help,action:,cis-pa:,cis-pl:,cis-policy:,cis-test:,verbose,only-fail -- "$@")
    [ $? -ne ${EXIT_SUCCESS} ] && help

    eval set -- "${cli_opts}"
    while [ "${1}" != "--" ]; do
        case "${1}" in
            -h|--help) help ;;

            -a|--action)
                action=${2}
                shift 2
            ;;

            --cis-pa)
                cis_pa=${2}
                shift 2
            ;;

            --cis-pl)
                cis_pl=${2}
                shift 2
            ;;        

            --cis-policy)
                cis_policy_file=${2}
                shift 2
            ;;

            --cis-test)
                cis_test_id=${2}
                shift 2
            ;;

            --verbose)
                verbose=${TRUE}
                shift
            ;;

            --only-fail)
                only_fail=${TRUE}
                shift
            ;;

            --)
                shift
                break
            ;;
        esac
    done
}

function check_run_params()
{
    # Set default options
    [ -z "${action}" ] && help
    [ -z "${cis_pa}" ] && cis_pa=${def_cis_pa}
    [ -z "${cis_pl}" ] && cis_pl=${def_cis_pl}
    [ -z "${verbose}" ] && verbose=${FALSE}
    [ -z "${only_fail}" ] && only_fail=${FALSE}

    if [[ ! "${actions_list[@]}" =~ "${action}" ]]; then
        echo "ERROR: unknown action [${action}]"
        help
    fi

    if [[ ! "${cis_pas_list[@]}" =~ "${cis_pa}" ]]; then
        echo "ERROR: unknown cis_pa [${cis_pa}]"
        help
    fi

    if [[ ! "${cis_pls_list[@]}" =~ "${cis_pl}" ]]; then
        echo "ERROR: unknown cis_pl [${cis_pl}]"
        help
    fi

    if [ -n "${cis_test_id}" -a "${action}" != "execute" ]; then
        echo "ERROR: --cis-test requires action:execute"
        help
    fi

    if [ -n "${cis_policy_file}" -a ! -e "${cis_policy_file}" ]; then
        echo "ERROR: policy file not found [${cis_policy_file}]"
        exit ${EXIT_FAILURE}
    fi
}

function get_os_name()
{
    if [ -e /etc/redhat-release ]; then
        os_name=$(rpm -q centos-release | perl -ne '/(centos)-release-(\d)-.*/ && print "$1-$2\n"')
    elif [ -e /etc/debian_version ]; then
        os_name="$(lsb_release -is)-$(lsb_release -rs)"
    fi

    # Turn os_name to lowercase
    os_name=${os_name,}
}

function check_os_support()
{
    get_os_name

    if [ -z "${os_name}" -o ! -d "${run_path}/${os_name}" ]; then
        echo "ERROR: unsupported OS [${os_name}]"
        exit ${EXIT_SUCCESS}
    fi
}

function process_test_list()
{
    echo "${cis_test_id}-${cis_test_name}"
}

function process_test_execute()
{
    if [ "${verbose}" -eq ${TRUE} ]; then
        cis_test_run
    else
        cis_test_run 2>/dev/null
    fi
    [ $? -eq ${EXIT_SUCCESS} ] && cis_test_status="SUCCESS" || cis_test_status="FAILURE"

    if [[ ($only_fail -eq $FALSE) || ($only_fail -eq $TRUE && $cis_test_status == "FAILURE") ]]; then
        echo "CIS_TEST_ID=\"${cis_test_id}\" CIS_TEST_NAME=\"${cis_test_name}\" CIS_TEST_STATUS=\"${cis_test_status}\""
    fi
}

function process_test()
{
    if [ -e "${cis_test_file}" ]; then
        cis_test_id=$(basename $cis_test_file | cut -d'.' -f1)
        cis_test_file_custom=${run_path}/${os_name}/custom/${cis_test_id}.sh
        [ -e "${cis_test_file_custom}" ] && cis_test_file=${cis_test_file_custom}
        source ${cis_test_file}
        
        case "${cis_pa}" in
            workstation)    cis_test_pl=${cis_test_spl} ;;
            server)         cis_test_pl=${cis_test_wpl} ;;
        esac
        
        if [[ "${cis_test_pa[@]}" =~ "${cis_pa}" ]]; then
            if [ ${cis_test_pl} -le ${cis_pl} ]; then
                process_test_${action}
            fi
        fi
    else
        echo "ERROR: test file not found [${cis_test_file}]"
    fi
}

function loop_tests()
{
    if [ -z "${cis_policy_file}" ]; then
        for cis_test_file in $(find ${run_path}/${os_name} -maxdepth 1 -type f | sort -V); do
            process_test
        done
    else
        for cis_test_id in $(cat ${cis_policy_file} | cut -d'-' -f1); do
            cis_test_file=${run_path}/${os_name}/${cis_test_id}.sh
            process_test
        done
    fi
}

function action_list()
{
    loop_tests
}

function action_execute()
{
    if [ -n "${cis_test_id}" ]; then
        cis_test_file=${run_path}/${os_name}/${cis_test_id}.sh
        process_test
    else
        loop_tests
    fi
}
# ---------------------------------------------------------


# MAIN
# ---------------------------------------------------------

# Available script actions
actions_list=(list execute)
# Available CIS profile applicabilities
cis_pas_list=(server workstation)
# Available CIS profile levels
cis_pls_list=(1 2)
# Run PATH (where to find script files)
run_path=$(dirname $0)
# Process CLI options
process_cli_opts $@
# Check run parameters
check_run_params
# Check OS support
check_os_support
# Execute script action
action_${action}

exit ${EXIT_SUCCESS}
# ---------------------------------------------------------

