#!/bin/bash
set -e

# Install Terragrunt
TERRAGRUNT_VERSION="0.45.0"
curl -Lo /tmp/terragrunt https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64
chmod +x /tmp/terragrunt
sudo mv /tmp/terragrunt /usr/local/bin/terragrunt

# Verify installation
terragrunt --version