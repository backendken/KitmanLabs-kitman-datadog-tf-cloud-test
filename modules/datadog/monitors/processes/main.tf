resource "datadog_monitor" "shoryuken_process_count_too_high" {
  name                = "[${var.environment}] shoryuken process count > ${var.shoryuken_process_count_threshold}!"
  type                = "metric alert"
  message             = "The ${var.environment} shoryuken process count is high on {{host.name}} in region: {{host.region}} Runbook: ${var.runbooks["shoryuken_process_count_too_high"]} ${var.notify} "
  query               = "avg(last_5m):max:system.processes.number{process_name:shoryuken,environment:${var.environment}} by {host}> ${var.shoryuken_process_count_threshold}"
  no_data_timeframe   = 30
  notify_no_data      = false
  require_full_window = true
  renotify_interval   = 20
  tags                = var.tags
}

resource "datadog_monitor" "shoryuken_process_count_too_low" {
  name                = "[${var.environment}] shoryuken process count < ${var.shoryuken_process_count_threshold}!"
  type                = "metric alert"
  message             = "The ${var.environment} shoryuken process count is low on {{host.name}} in region: {{host.region}} Runbook: ${var.runbooks["shoryuken_process_count_too_low"]} ${var.notify} "
  query               = "avg(last_5m):max:system.processes.number{process_name:shoryuken,environment:${var.environment}} by {host}< ${var.shoryuken_process_count_threshold}"
  no_data_timeframe   = 30
  notify_no_data      = false
  require_full_window = true
  renotify_interval   = 20
  tags                = var.tags
}
