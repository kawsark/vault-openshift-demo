#!/bin/bash
source ./env.sh

echo "INFO: Removing json files"
rm response.json
rm login*.json

echo "INFO: Removing Vault Auth Method and Secret Engine"
vault auth disable $VAULT_AUTH_PATH
vault secrets disable $VAULT_SECRET_PATH

echo "INFO: Removing service accounts and project from OpenShift"
oc delete sa ${OC_SA}
oc delete sa ${OC_SA_APP}
oc delete project ${OC_PROJECT}