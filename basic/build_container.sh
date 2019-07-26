#!/bin/bash

./build
docker build -t kawsark/vault-example-init:0.0.7 .
rm vault-init
