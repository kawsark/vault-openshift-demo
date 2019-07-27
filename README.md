# vault-openshift-demo
This repository provides supporting scripts and an example Golang application for the Vault OpenShift guide blog post. These scripts can be run on a standard unix terminal. 

### Pre-requisites
1. OpenShift `oc` CLI should be setup with administrative access.
1. OpenShift API server `ca.crt` file should be in the current directory. For default installs this file is located in: `/etc/origin/master/ca.crt`. Please copt this file to the current directory. Example command: `sudo cp /etc/origin/master/ca.crt .`
1. `curl` and `jq` utilities should be installed. 
1. `vault` binary should be on your PATH. You can [download Vault binary here](https://www.vaultproject.io/downloads.html).
1. Please adjust the environment variables under `Setup environment` appropriately.

### Running the scripts
```
# Setup environment
export K8S_API_SERVER="https://master.ocp.example.org"
export VAULT_ADDR="https://vault.example.org:8200"
export VAULT_TOKEN="admin-or-root-token"

# Clone repo and adjust permissions
git clone https://github.com/kawsark/vault-openshift-demo.git
cd vault-openshift-demo
chmod +x *.sh

# (Optional) Adjust variable default in env.sh
vi env.sh

# Execute scripts
./0_openshift_setup.sh
./1_vault_setup.sh
./2_test_vault_login.sh
./3_deploy_app.sh
```

### Clean up
Please ensure that the environment variables `K8S_API_SERVER`, `VAULT_ADDR` and `VAULT_TOKEN` are set properly. Then run the clean script. 
- **Careful**: this will delete the OpenShift project, 2 service accounts, Vault Auth method and Vault secrets engine.
```
./0_cleanup.sh
```
