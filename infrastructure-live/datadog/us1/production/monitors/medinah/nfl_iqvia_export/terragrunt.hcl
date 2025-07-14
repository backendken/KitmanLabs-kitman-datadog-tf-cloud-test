include "root" {
  path = find_in_parent_folders()
}

locals {
  env_vars         = read_terragrunt_config(find_in_parent_folders("env_config.hcl"))
  site_config_vars = read_terragrunt_config(find_in_parent_folders("site_config.hcl"))
  notify           = local.site_config_vars.locals.notify
}

terraform {
  source = "${get_repo_root()}/modules/datadog/monitors/medinah//${basename(get_terragrunt_dir())}"
}

inputs = merge(
  local.env_vars.inputs,
  local.site_config_vars.inputs,
  {
    notify = "@slack-squad-migrations-errors"
    regions = ["us-east-1"]
  }
)
