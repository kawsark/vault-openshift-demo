#!/bin/bash
source ./env.sh

# Create a deployment.yaml file:
echo "Writing deployment.yaml file:"
cat <<EOF> deployment.yaml
apiVersion: apps/v1beta1
kind: Deployment
metadata:
  name: basic-example
  namespace: vault-demo
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: basic-example
    spec:
      serviceAccountName: ${OC_SA_APP}
      containers:
        - name: app
          image: "${IMAGE}"
          imagePullPolicy: Always
          env:
            - name: VAULT_ADDR
              value: "${VAULT_ADDR}"
            - name: VAULT_ROLE
              value: "${VAULT_ROLE}"
            - name: SECRET_KEY
              value: "$app_secret_path"
            - name: VAULT_LOGIN_PATH
              value: "auth/${VAULT_AUTH_PATH}/login"
EOF

cat deployment.yaml

# Create deployment and check that the application pod is running
oc create -f deployment.yaml

echo "Waiting 10 seconds for pod to deploy"
sleep 10

pod=$(oc get pods -o json )
