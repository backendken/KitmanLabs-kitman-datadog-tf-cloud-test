resource "datadog_monitor" "capture" {
  message             = "The difference between left and right hip mobility attempts is too high ${var.runbook} ${var.notify}"
  name                = "[${element(var.regions, count.index)}] Capture Hip Mobility Attempts - Difference between Left and Right"
  query               = "avg(last_5m):abs( max:capture.capture_hip_mobility_right_attempts_count{region:${element(var.regions, count.index)}} - max:capture.capture_hip_mobility_left_attempts_count{region:${element(var.regions, count.index)}} ) > 10"
  type                = "query alert"
  require_full_window = false
  notify_no_data      = false
  tags                = var.tags
  count               = length(var.regions)
}
