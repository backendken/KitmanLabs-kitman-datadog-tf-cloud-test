include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_repo_root()}/modules/datadog/dashboards//${basename(get_terragrunt_dir())}"
}
