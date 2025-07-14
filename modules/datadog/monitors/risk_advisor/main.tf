resource "datadog_monitor" "risk_advisor_model_creation_monitor" {
  name                = "[${var.environment}] - [${element(var.regions, count.index)}] Step function monitor for Risk Advisor Creation"
  type                = "metric alert"
  message             = "[${var.environment}] An injury risk variable model creation has failed. ${var.notify} ${var.runbook}"
  query               = "sum(last_1h):max:aws.states.executions_failed{organization:${var.environment},statemachinearn:arn:aws:states:${element(var.regions, count.index)}:${var.accounts[var.environment]}:statemachine:multivariate_analysis_emr_state_machine}.as_count() >= 1"
  notify_no_data      = false
  require_full_window = false
  renotify_interval   = 0
  count               = length(var.regions)
  tags                = var.tags
}

resource "datadog_monitor" "risk_advisor_prediction_generation_monitor" {
  name                = "[${var.environment}] - [${element(var.regions, count.index)}] Step function monitor for Risk Advisor Prediction Generation"
  type                = "metric alert"
  message             = "[${var.environment}] A Risk Advisor prediction generation has failed. ${var.notify} ${var.runbook}"
  query               = "sum(last_1h):max:aws.states.executions_failed{organization:${var.environment},statemachinearn:arn:aws:states:${element(var.regions, count.index)}:${var.accounts[var.environment]}:statemachine:multivariate_predict_state_machine}.as_count() >= 5"
  notify_no_data      = false
  require_full_window = false
  renotify_interval   = 0
  count               = length(var.regions)
  tags                = var.tags
}
