resource "datadog_logs_archive" "s3_log_archive" {
  name  = "[${var.environment}] - [${element(var.regions, count.index)}] S3 Archive"
  query = var.query != "" ? var.query : "environment:${var.environment} region:${element(var.regions, count.index)}"

  s3_archive {
    bucket     = "${element(var.regions, count.index)}-${var.accounts[var.environment]}-kitman-logs"
    path       = var.path
    account_id = var.accounts[var.environment]
    role_name  = var.role_name
  }

  include_tags = true
  count        = length(var.regions)
}
