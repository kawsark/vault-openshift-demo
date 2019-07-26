#!/bin/bash

# This script contains default values for various OpenShift and Vault configuration paths. 
# Please adjust these as needed

# This project will be created in OpenShift
export OC_PROJECT="vault-demo"

# This service account will be created. 
# It will be used to call OpenShift/Kubernetes TokenReview API by vault
export OC_SA="vault-auth"

# This service account will be created for the application Pod
export OC_SA_APP="app1"

# Path in Vault where the Authentication method will be mounted
export VAULT_AUTH_PATH="ocp"

# Path in Vault where the Static secret engine will be mounted
export VAULT_SECRET_PATH="secret"

# Role name in Vault for the application
export VAULT_ROLE="app1-role"

# ACL policy to be enforced upon successful authentication
export VAULT_POLICY="app1-policy"

# Docker image and label for example application
export IMAGE="kawsark/vault-example-init:0.0.7"

# ~~~~~~ Do not adjust the following, it will get populated using previous values ~~~~~~
export app_secret_path="${VAULT_SECRET_PATH}/${OC_APP_SA}"
