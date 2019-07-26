#!/bin/bash
source ./env.sh

echo "Testing login using vault CLI"
# Login using vault CLI
vault write "auth/${VAULT_AUTH_PATH}/login" \
  role="${VAULT_ROLE}" \
  jwt="$(oc sa get-token ${OC_APP_SA})" > login.json

echo "Response from login - CLI:"
cat login.json
export VAULT_TOKEN="$(cat login.json | jq -r .data.client_token)"
echo "Looking up token:"
vault token lookup

# Read a secret using Vault token - vault CLI
echo "Reading secret from $app_secret_path"
vault read $app_secret_path

# Login using curl
cat <<EOF > payload.json
  { "role":"${VAULT_ROLE}", "jwt":"$(oc sa get-token ${OC_APP_SA})" }
EOF
curl --request POST --data @payload.json \
   "${VAULT_ADDR}/v1/auth/${VAULT_AUTH_PATH}/login" > login-curl.json

echo "Response from login - curl:"
cat login-curl.json

# Read a secret using Vault token - curl
echo "Reading secret from $app_secret_path"
export VAULT_TOKEN="$(cat login-curl.json | jq -r .data.client_token)"
curl -H "X-Vault-Token: ${VAULT_TOKEN}" "${VAULT_ADDR}/v1/$app_secret_path"