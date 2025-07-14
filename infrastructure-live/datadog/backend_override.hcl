# Override the S3 backend with Terraform Cloud
remote_state {
  backend = "remote"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    hostname     = "app.terraform.io"
    organization = "kitman-cloud-test"
    workspaces = {
      name = "${get_env("TFC_WORKSPACE_NAME", "")}"
    }
  }
}