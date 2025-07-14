locals {
  backend      = read_terragrunt_config(find_in_parent_folders("site_config.hcl"))
  config_json  = run_cmd("bash", "${get_repo_root()}/bin/${local.backend.locals.datadog_site_code}/account_check.sh")
  base_configs = try(jsondecode(local.config_json))
}

inputs = {
  tf_dd_version = "terraform"
  tags          = ["terraform", "kitman-datadog v2.0"]
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket                   = local.base_configs.aws_state_bucket
    region                   = local.base_configs.aws_default_region
    key                      = "datadog/${path_relative_to_include()}/terraform.tfstate"
    dynamodb_table           = "terraform-locks"
    skip_bucket_enforced_tls = true
    skip_bucket_root_access  = true
    encrypt                  = true
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
      version = "~> 3.0"
    }
  }
}
EOF
}
