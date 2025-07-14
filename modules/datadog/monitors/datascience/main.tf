resource "datadog_monitor" "fusion_step_function_monitor" {
  name                = "[${var.environment}] - [${element(var.regions, count.index)}] Fusion Step function monitor"
  type                = "metric alert"
  message             = "A ${var.environment} fusion step function has failed ${var.runbook} ${var.notify}"
  query               = "sum(last_1h):max:aws.states.executions_failed{organization:${var.environment},statemachinearn:arn:aws:states:${element(var.regions, count.index)}:${var.accounts[var.environment]}:statemachine:fusion_state_machine} by {statemachinearn}.as_count() >= 1"
  notify_no_data      = false
  require_full_window = false
  renotify_interval   = 0
  count               = length(var.regions)
  tags                = var.tags
}

resource "datadog_monitor" "fusion_metric_finder_step_function_monitor" {
  name                = "[${var.environment}] - [${element(var.regions, count.index)}] Fusion Metric Finder Step function monitor"
  type                = "metric alert"
  message             = "A ${var.environment} fusion metric finder step function has failed ${var.runbook} ${var.notify}"
  query               = "sum(last_1h):max:aws.states.executions_failed{organization:${var.environment},statemachinearn:arn:aws:states:${element(var.regions, count.index)}:${var.accounts[var.environment]}:statemachine:fusion_metric_finder} by {statemachinearn}.as_count() >= 1"
  notify_no_data      = false
  require_full_window = false
  renotify_interval   = 0
  count               = length(var.regions)
  tags                = var.tags
}

resource "datadog_monitor" "fusion_fetch_step_function_monitor" {
  name                = "[${var.environment}] - [${element(var.regions, count.index)}] Fusion Fetch Step function monitor"
  type                = "metric alert"
  message             = "A ${var.environment} fusion fetch step function has failed ${var.runbook} ${var.notify}"
  query               = "sum(last_1h):max:aws.states.executions_failed{organization:${var.environment},statemachinearn:arn:aws:states:${element(var.regions, count.index)}:${var.accounts[var.environment]}:statemachine:fusion_fetch_sf} by {statemachinearn}.as_count() >= 1"
  notify_no_data      = false
  require_full_window = false
  renotify_interval   = 0
  count               = length(var.regions)
  tags                = var.tags
}
