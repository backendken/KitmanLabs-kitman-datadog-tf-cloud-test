resource "datadog_monitor" "code_coverage" {
  count               = length(keys(var.stacks))
  name                = "Code Coverage Alert for ${title(element(keys(var.stacks), count.index))}!"
  type                = "metric alert"
  message             = "Code Coverage Alert for ${title(element(keys(var.stacks), count.index))} - Runbook: ${lookup(var.runbooks, element(keys(var.stacks), count.index), var.default_runbook)} ${var.notify} "
  query               = "avg(last_5m):min:developerexperience.code_coverage{stack:${element(keys(var.stacks), count.index)}} < ${element(values(var.stacks), count.index)}"
  notify_no_data      = false
  require_full_window = true
  renotify_interval   = 20
  tags                = var.tags
}
