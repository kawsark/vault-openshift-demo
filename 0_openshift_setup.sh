#!/bin/bash
source ./env.sh

echo "INFO: Trying to reach OpenShift API server: ${K8S_API_SERVER}/healthz"
curl -kv "${K8S_API_SERVER}/healthz"

# Create new project:
echo "INFO: Creating project: ${OC_PROJECT}"
oc new-project "${OC_PROJECT}"
oc projects

# Create token reviewer service account and cluster role binding 
echo "INFO: Creating token reviewer service account: ${OC_SA}"
oc create sa "${OC_SA}"
oc describe sa "${OC_SA}"
oc adm policy add-cluster-role-to-user \
  system:auth-delegator system:serviceaccount:"${OC_PROJECT}":"${OC_SA}"
oc serviceaccounts get-token "${OC_SA}" > reviewer_sa_jwt.txt

echo "INFO: Creating app service account: ${OC_SA_APP}"
oc create sa "$OC_SA_APP"
oc describe sa "${OC_SA_APP}"
