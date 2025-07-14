resource "datadog_monitor" "mlkit_training_import_monitor" {
  name                = "[${var.environment}] Training Import Monitor for MLKit"
  type                = "metric alert"
  message             = "[${var.environment}] An MLKit Training Import has failed. ${var.notify} ${var.runbook}"
  query               = "avg(last_1d):abs((sum:mlkit.${var.environment}.import.pymix_risk_advisor.failed{*} by {region}.as_count() / sum:mlkit.production.import.pymix_risk_advisor.started{*} by {region}.as_count()) * 100) > 5"
  notify_no_data      = false
  require_full_window = false
  renotify_interval   = 0
  tags                = var.tags
}

resource "datadog_monitor" "mlkit_prediction_import_monitor" {
  name                = "[${var.environment}] Prediction Import Monitor for MLKit"
  type                = "metric alert"
  message             = "[${var.environment}] An MLKit Prediction Import has failed. ${var.notify} ${var.runbook}"
  query               = "avg(last_1d):abs((sum:mlkit.${var.environment}.import.pymix_risk_advisor_predictions.failed{*} by {region}.as_count() / sum:mlkit.production.import.pymix_risk_advisor_predictions.started{*} by {region}.as_count()) * 100) > 5"
  notify_no_data      = false
  require_full_window = false
  renotify_interval   = 0
  tags                = var.tags
}
