resource "datadog_monitor" "aurora_cpu_monitor" {
  name                = "[${var.environment}] - [${element(var.regions, count.index)}] High CPU on Aurora"
  type                = "metric alert"
  message             = "High CPU on Aurora! Runbook: ${var.runbooks["cpu_monitor"]} ${var.notify} "
  query               = "avg(last_10m):max:aws.rds.cpuutilization{${join(",", var.includes)},region:${element(var.regions, count.index)},organization:${var.environment}} by {host} > ${var.cpu_threshold}"
  notify_no_data      = false
  require_full_window = false
  renotify_interval   = 20
  new_group_delay     = var.new_group_delay
  count               = contains(var.cpu_envs, var.environment) ? length(var.regions) : 0
  tags                = var.tags

  monitor_thresholds {
    critical = var.cpu_threshold
  }
}

resource "datadog_monitor" "aurora_backup_not_running" {
  name                = "[${var.environment}] - [${element(var.regions, count.index)}] DB Backup is not running"
  type                = "metric alert"
  message             = "DB Backup is not running! Runbook: ${var.runbooks["backup_not_running"]} ${var.notify} "
  query               = "min(last_1h):max:operations.dbbackup_successful{region:${element(var.regions, count.index)},organization:${var.environment}} < 1"
  notify_no_data      = true
  require_full_window = false
  renotify_interval   = 20
  no_data_timeframe   = 120
  count               = contains(var.backup_envs, var.environment) ? length(var.regions) : 0
  priority            = 2
  tags                = var.tags
}

resource "datadog_monitor" "aurora_restore_failed" {
  name                = "[${var.environment}] - [${element(var.regions, count.index)}] DB Restore Failed"
  type                = "metric alert"
  message             = "DB Restore Failed! Runbook: ${var.runbooks["restore_failed"]} ${var.notify} "
  query               = "max(last_15m):max:operations.restore_db_failed{region:${element(var.regions, count.index)},organization:${var.environment}} > 0.5"
  notify_no_data      = false
  require_full_window = false
  renotify_interval   = 20
  count               = contains(var.restore_envs, var.environment) ? length(var.regions) : 0
  priority            = 3
  tags                = var.tags
}

resource "datadog_monitor" "obfuscation_failed" {
  name                = "[${var.environment}] - [${element(var.regions, count.index)}] DB Obfuscation has failed"
  type                = "metric alert"
  message             = "DB Obfuscation process has failed! Runbook: ${var.runbooks["obfuscation_failed"]} ${var.notify} "
  query               = "max(last_15m):max:operations.obfuscated_dbbackup_failed{region:${element(var.regions, count.index)},organization:${var.environment}} > 0.5"
  notify_no_data      = false
  require_full_window = false
  renotify_interval   = 20
  count               = contains(var.obfuscate_envs, var.environment) ? length(var.regions) : 0
  priority            = 3
  tags                = var.tags
}
