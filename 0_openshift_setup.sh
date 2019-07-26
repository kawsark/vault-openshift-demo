#!/bin/bash
source ./env.sh

echo "Trying to reach OpenShift API server: ${K8S_API_SERVER}/healthz"
curl -kv "${K8S_API_SERVER}/healthz"

# Create new project:
echo "Creating project: ${OC_PROJECT}"
oc new-project "${OC_PROJECT}"
oc projects

# Create token reviewer service account and cluster role binding 
echo "Creating token reviewer service account: ${OC_SA}"
oc create sa "${OC_SA}"
oc adm policy add-cluster-role-to-user \
  system:auth-delegator system:serviceaccount:"${OC_PROJECT}":"${OC_SA}"
oc serviceaccounts get-token "${OC_SA}" > reviewer_sa_jwt.txt

echo "Creating app service account: ${OC_SA}"
# Lets create two more serviceaccounts for applications
oc create sa "${OC_SA}"
oc describe "${OC_SA}"
