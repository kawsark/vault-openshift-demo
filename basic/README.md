This directory contains an example GoLang application which uses Vault's Kubernetes Auth method. Application code is in [main.go](main.go) file. To build the application from source, [Golang SDK]() needs to be installed on the system.

- To build this application, please run `./build.sh`. 
- To build a container image: 
  - Edit the `build_container.sh` file by replacing `kawsark/vault-example-init:0.0.7` with: `<your-registry-username>/<image-name>:<tag>`
  - Run `./build_container.sh`
```