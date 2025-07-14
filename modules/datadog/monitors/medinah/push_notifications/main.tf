resource "datadog_monitor" "push_notifications" {
  name                = "[${var.environment}] - [${element(var.regions, count.index)}] Urban Airship Pushes are failing"
  type                = "metric alert"
  message             = "Urban Airship Pushes are failing. Runbook: ${var.runbooks["push_notifications"]} ${var.notify} "
  query               = "sum(last_5m):avg:medinah.${var.environment}.training_session.push_notification.urban_airship.exception{region:${element(var.regions, count.index)}}.as_count() > 1"
  notify_no_data      = false
  require_full_window = false
  renotify_interval   = 20
  tags                = var.tags
  count               = length(var.regions)
}
