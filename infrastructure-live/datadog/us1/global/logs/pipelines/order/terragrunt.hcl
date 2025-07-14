include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_repo_root()}/modules/datadog/logs/pipelines//${basename(get_terragrunt_dir())}"
}

dependency "nginx" {
  config_path = "../nginx"

  mock_outputs = {
    nginx_id        = "temporary-dummy-id"
    nginx_kitman_id = "temporary-dummy-id"
  }
}

dependency "sidekiq" {
  config_path = "../sidekiq"

  mock_outputs = {
    sidekiq_id = "temporary-dummy-id"
  }
}

dependency "symbiosis" {
  config_path = "../symbiosis"

  mock_outputs = {
    symbiosis_id = "temporary-dummy-id"
  }
}

dependency "aws_lambda" {
  config_path = "../aws_lambda"

  mock_outputs = {
    aws_lambda_id = "temporary-dummy-id"
  }
}

inputs = {
  pipeline_ids = [
    dependency.nginx.outputs.nginx_id,
    dependency.nginx.outputs.nginx_kitman_id,
    dependency.sidekiq.outputs.sidekiq_id,
    dependency.symbiosis.outputs.symbiosis_id,
    dependency.aws_lambda.outputs.aws_lambda_id
  ]
}
