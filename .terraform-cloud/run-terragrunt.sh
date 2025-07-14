#!/bin/bash
set -e

# Install Terragrunt if not present
if ! command -v terragrunt &> /dev/null; then
    echo "Installing Terragrunt..."
    ./.terraform-cloud/setup.sh
fi

# Determine the working directory based on workspace name
# Expected format: datadog-{site}-{environment}-{component}
WORKSPACE_NAME="${TFC_WORKSPACE_NAME}"
IFS='-' read -ra PARTS <<< "$WORKSPACE_NAME"

# Extract parts
SITE="${PARTS[1]}"  # us1 or us1-fed
ENV="${PARTS[2]}"   # sandbox, staging, production

# Build the path
WORK_DIR="infrastructure-live/datadog/${SITE}/${ENV}"

# Change to the appropriate directory
cd "${WORK_DIR}"

# Run terragrunt with the appropriate command
case "${TFC_TERRAFORM_COMMAND}" in
    "plan")
        terragrunt plan -input=false
        ;;
    "apply")
        terragrunt apply -input=false -auto-approve
        ;;
    *)
        echo "Unknown command: ${TFC_TERRAFORM_COMMAND}"
        exit 1
        ;;
esac