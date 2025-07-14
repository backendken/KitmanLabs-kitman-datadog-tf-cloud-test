resource "datadog_monitor" "elasticache_cpu_utilisation" {
  name                = "[${element(var.regions, count.index)}] Elasticache cluster CPU too high"
  type                = "metric alert"
  message             = "Elasticache cluster CPU too high! ${var.runbook["cpuutilization"]} ${var.notify} "
  query               = "avg(last_5m):max:aws.elasticache.cpuutilization{region:${element(var.regions, count.index)}} > 75"
  notify_no_data      = false
  require_full_window = false
  renotify_interval   = 0
  count               = length(var.regions)
  tags                = var.tags
}

resource "datadog_monitor" "elasticache_evictions" {
  name                = "[${element(var.regions, count.index)}] Elasticache evictions too high"
  type                = "metric alert"
  message             = "Elasticache evictions too high! ${var.runbook["evictions"]} ${var.notify} "
  query               = "sum(last_5m):max:aws.elasticache.evictions{region:${element(var.regions, count.index)}} > 0"
  notify_no_data      = false
  require_full_window = false
  renotify_interval   = 0
  count               = length(var.regions)
  tags                = var.tags
}
