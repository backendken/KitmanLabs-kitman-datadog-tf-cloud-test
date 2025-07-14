resource "datadog_monitor" "athlete_user_permissions_monitor" {
  name    = "[${var.environment}] - [${element(var.regions, count.index)}] Wrong permissions added to an athlete user"
  type    = "metric alert"
  message = "A recent change or task has given to athlete user(s) the wrong permissions. ${var.notify}"
  query   = "avg(last_5m):max:watchtower.database_query{region:${element(var.regions, count.index)},watcher_name:athlete_user_permissions,environment:${var.environment}} > 0"

  monitor_thresholds {
    critical = 0
  }

  notify_no_data      = false
  require_full_window = false
  renotify_interval   = 20
  tags                = var.tags
  count               = length(var.regions)
}
