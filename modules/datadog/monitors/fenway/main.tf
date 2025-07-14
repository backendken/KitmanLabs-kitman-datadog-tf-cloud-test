resource "datadog_monitor" "fenway_process_time" {
  name                = "[${var.environment}] - [${element(var.regions, count.index)}] Fenway high time to process"
  type                = "metric alert"
  message             = "Fenway high time to process ${var.runbooks["fenway_process_time"]} ${var.notify} "
  query               = "max(last_5m):max:fenway.${var.environment}.request.time_to_process.max{region:${element(var.regions, count.index)}} >= ${var.threshold}"
  notify_no_data      = false
  require_full_window = true
  renotify_interval   = 20
  count               = length(var.regions)
  tags                = var.tags
}
