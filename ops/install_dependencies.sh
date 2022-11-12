#!/bin/bash

## INSTALL PACKER ##
PACKER_VERSION=1.8.4
wget https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip
unzip packer_${PACKER_VERSION}_linux_amd64.zip -d ops/
ops/packer -v

## INSTALL TERRAFORM ##
curl https://releases.hashicorp.com/terraform/1.2.5/terraform_1.2.5_linux_amd64.zip -L -o ./terraform.zip
unzip terraform.zip -d ops/