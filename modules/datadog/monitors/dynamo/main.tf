resource "datadog_monitor" "dynamo" {
  message             = "The dynamo capacity is too high! This may incur significant costs ${var.runbook} ${var.notify}"
  name                = "[${var.environment}] - [${element(var.regions, count.index)}] Dynamo capacity for ${var.table} is higher than usual"
  query               = "avg(last_1d):avg:aws.dynamodb.provisioned_write_capacity_units{tablename:${var.table}} > ${var.threshold}"
  type                = "query alert"
  require_full_window = false
  notify_no_data      = false
  renotify_interval   = 720
  count               = length(var.regions)
  tags                = var.tags
}
