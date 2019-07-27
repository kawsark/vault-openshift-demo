#!/bin/bash
source ./env.sh

vault auth disable $VAULT_AUTH_PATH
vault secrets disable $VAULT_SECRET_PATH
oc delete sa ${OC_SA}
oc delete sa ${OC_SA_APP}
oc delete project ${OC_PROJECT}