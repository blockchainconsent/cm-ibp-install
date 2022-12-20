#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"
IMPORT_EXPORT_REQUIRED=0
function usage {
    echo "Usage: add-org-to-ibp.sh [-i] [build|destroy]" 1>&2
    exit 1
}
while getopts ":i" OPT; do
    case ${OPT} in
        i)
            IMPORT_EXPORT_REQUIRED=1
            ;;
        \?)
            usage
            ;;
    esac
done
shift $((OPTIND -1))
COMMAND=$1
if [ "${COMMAND}" = "build" ]; then
    set -x
#HCLSIBP/playbooks/playbook-files/02a-nys-org.yml
    # Create new org
    ansible-playbook -vvv -e "org_var_file=02a-new-org.yml" 03-create-endorsing.yml

    # add the org to the consortium
    ansible-playbook -vvv -e "order_var_file=01-ordering-org-vars.yml org_var_file=02a-new-org.yml" 05-add-org-to-consortium.yml
    # add the org to the channel
    #ansible-playbook -e "org_var_file=02a-nys-org.yml channel_var_file=02a-hpass_ch_def.yml" 14-add-organization-to-channel.yml
    #ansible-playbook -vvv -e "org_var_file=02a-nys-org.yml channel_var_file=02a-hpass_ch_def.yml" 09-join-peer-to-channel.yml
    #ansible-playbook -vvv -e "org_var_file=02a-nys-org.yml channel_var_file=02a-hpass_ch_def.yml" 10-add-anchor-peer-to-channel.yml

    set +x
# elif [ "${COMMAND}" = "destroy" ]; then
#     set -x
#     if [ "${IMPORT_EXPORT_REQUIRED}" = "1" ]; then
#         # ansible-playbook 97-delete-endorsing-organization-components.yml --extra-vars '{"import_export_used":true}'
#         # ansible-playbook 99-delete-ordering-organization-components.yml --extra-vars '{"import_export_used":true}'
#     else
#         # ansible-playbook 97-delete-endorsing-organization-components.yml
#         # ansible-playbook 99-delete-ordering-organization-components.yml
#     fi
#     set +x
else
    usage
fi
