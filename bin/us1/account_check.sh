#!/usr/bin/env bash

account_id=$(aws sts get-caller-identity | jq .Account | tr -d \")

if [ $account_id != 499219461927 ]; then
    echo ''
    echo '#######################################################################################################################'
    echo 'Account mismatch please use:'
    echo 'aws-vault exec production-<engineers|poweruser> -- chamber exec datadog -- terragrunt <init|plan|apply|output|destroy>'
    echo '#######################################################################################################################'
    echo ''

    exit 1
fi

printf '{"aws_state_bucket":"%s","aws_default_region":"%s"}' "kitman-${account_id}-state" "$AWS_DEFAULT_REGION"
