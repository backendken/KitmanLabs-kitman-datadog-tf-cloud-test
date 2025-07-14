resource "datadog_monitor" "forklift_unload_step_function_monitor" {
  name                = "[${var.environment}] - [${element(var.regions, count.index)}] Forklift unload step function monitor"
  type                = "metric alert"
  message             = "A ${var.environment} forklift unload step function has failed ${var.runbook} ${var.notify}"
  query               = "sum(last_1h):max:aws.states.executions_failed{organization:${var.environment},statemachinearn:arn:aws:states:${element(var.regions, count.index)}:${var.accounts[var.environment]}:statemachine:forklift_unload} by {statemachinearn}.as_count() >= 1"
  notify_no_data      = false
  require_full_window = false
  renotify_interval   = 0
  count               = length(var.regions)
  tags                = var.tags
}

resource "datadog_monitor" "forklift_refresh_step_function_monitor" {
  name                = "[${var.environment}] - [${element(var.regions, count.index)}] Forklift refresh step function monitor"
  type                = "metric alert"
  message             = "A ${var.environment} forklift refresh step function has failed ${var.runbook} ${var.notify}"
  query               = "sum(last_1h):max:aws.states.executions_failed{organization:${var.environment},statemachinearn:arn:aws:states:${element(var.regions, count.index)}:${var.accounts[var.environment]}:statemachine:forklift_sf} by {statemachinearn}.as_count() >= 1"
  notify_no_data      = false
  require_full_window = false
  renotify_interval   = 0
  count               = length(var.regions)
  tags                = var.tags
}
