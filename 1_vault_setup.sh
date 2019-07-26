#!/bin/bash
source ./env.sh

echo "Checking connectivity to vault server: ${VAULT_ADDR}, and vault token"
curl -kv "${VAULT_ADDR}/v1/sys/health"
vault status
vault token lookup

echo "Creating application policy for ${OC_APP_SA}"
# Create application policy
cat <<EOF > policy.hcl
  path "${app_secret_path}" {
    capabilities = ["read", "list"]
  }
EOF
vault policy write "${OC_APP_SA}-policy" policy.hcl
vault policy read "${OC_APP_SA}-policy"

echo "Writing example secret to $app_secret_path"
# Write an example static secret
vault secrets enable -path="${VAULT_SECRET_PATH}" -version=1 kv
vault kv put $app_secret_path username=${OC_APP_SA} password=supasecr3t
vault read $app_secret_path

echo "Checking for ca.crt file in current directory"
ls -l ./ca.crt

# Enable and configure the Auth method in Vault
export REVIEWER_JWT="$(cat reviewer_sa_jwt.txt)"
echo "Enabling kubernetes Auth method at path: ${VAULT_AUTH_PATH}"
vault auth enable -path=${VAULT_AUTH_PATH} kubernetes
vault write "auth/${VAULT_AUTH_PATH}/config" \
  token_reviewer_jwt="${REVIEWER_JWT}" \
  kubernetes_host="${K8S_API_SERVER}" \
  kubernetes_ca_cert=@ca.crt

# Configure the role in Vault
echo "Configuring Auth method"
vault write "auth/${VAULT_AUTH_PATH}/role/${VAULT_ROLE}" \
  bound_service_account_names="default,${OC_APP_SA}" \
  bound_service_account_namespaces="${OC_PROJECT}" \
  policies="${VAULT_POLICY}" ttl=2h

vault read "auth/${VAULT_AUTH_PATH}/role/${VAULT_ROLE}"

