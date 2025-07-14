resource "datadog_monitor" "console_demo_create_error" {
  name                = "[${var.environment}] - [${element(var.regions, count.index)}] Error Creating Demo accounts"
  type                = "metric alert"
  message             = "Error Creating Demo accounts ${var.runbooks["create_error"]} ${var.notify}"
  query               = "max(last_5m):sum:console_api.${var.environment}.demo_account.create.error{region:${element(var.regions, count.index)}} > 0"
  notify_no_data      = false
  require_full_window = true
  renotify_interval   = 60
  count               = length(var.regions)
  tags                = var.tags
}

resource "datadog_monitor" "console_demo_delete_error" {
  name                = "[${var.environment}] - [${element(var.regions, count.index)}] Error deleting Demo accounts"
  type                = "metric alert"
  message             = "Error deleting Demo accounts ${var.runbooks["delete_error"]} ${var.notify}"
  query               = "max(last_5m):sum:console_api.${var.environment}.demo_account.delete.error{region:${element(var.regions, count.index)}} > 0"
  notify_no_data      = false
  require_full_window = true
  renotify_interval   = 60
  count               = length(var.regions)
  tags                = var.tags
}
