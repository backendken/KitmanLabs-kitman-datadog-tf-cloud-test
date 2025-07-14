resource "datadog_monitor" "athlete_api_crash" {
  name                = "[${var.environment}] - [${element(var.regions, count.index)}] Athlete API Crashes > ${var.crash_threshold} in the last 24 hours"
  type                = "metric alert"
  message             = "Athlete API Crashes > ${var.crash_threshold} in the last 24 hours ${var.runbooks["crash"]} ${var.notify}"
  query               = "sum(last_1d):sum:athlete_api.${var.environment}.event{event_name:crash,region:${element(var.regions, count.index)}}.as_count() > ${var.crash_threshold}"
  notify_no_data      = false
  require_full_window = false
  renotify_interval   = 20
  tags                = var.tags
  count               = length(var.regions)
}

resource "datadog_monitor" "athlete_api_completed_questionnaire_processor" {
  name                = "[${var.environment}] - [${element(var.regions, count.index)}] Completed Questionnaire Processor failed to complete successfully"
  type                = "metric alert"
  message             = "Completed Questionnaire Processor failed to complete successfully. ${var.runbooks["completed_questionnaire_processor"]} ${var.notify} "
  query               = "max(last_5m):avg:athlete_api.${var.environment}.completed_questionnaire_processor.failure{region:${element(var.regions, count.index)}} > 1"
  notify_no_data      = false
  require_full_window = true
  renotify_interval   = 20
  tags                = var.tags
  count               = length(var.regions)
}

resource "datadog_monitor" "athlete_api_completed_questionnaire_dlq" {
  name                = "[${var.environment}] - [${element(var.regions, count.index)}] Completed questionnaires in the DLQ"
  type                = "metric alert"
  message             = "Check the questionnaires in the DLQ. ${var.runbooks["completed_questionnaire_dlq"]} ${var.notify} "
  query               = "avg(last_1h):max:aws.sqs.approximate_number_of_messages_visible{queuename:worker_completed_questionnaires_dlq,region:${element(var.regions, count.index)}} > 5"
  notify_no_data      = false
  require_full_window = true
  renotify_interval   = 20
  tags                = var.tags
  count               = length(var.regions)
}

resource "datadog_monitor" "athlete_api_sms_successrate" {
  name                = "[${var.environment}] - [${element(var.regions, count.index)}] SMS Success rate has dipped"
  type                = "metric alert"
  message             = "SMS messages are failing to deliver ${var.runbooks["sms_failures"]} ${var.notify} "
  query               = "avg(last_1h):avg:aws.sns.smssuccess_rate{region:${element(var.regions, count.index)}} < ${var.smssuccess_critical_rate}"
  notify_no_data      = false
  require_full_window = false
  timeout_h           = 1
  tags                = var.tags
  count               = length(var.regions)

  monitor_thresholds {
    critical = var.smssuccess_critical_rate
    warning  = var.smssuccess_warning_rate
  }
}

resource "datadog_monitor" "athlete_api_sms_budget" {
  name                = "[${var.environment}] - [${element(var.regions, count.index)}] SMS budget is at risk of being exceeded"
  type                = "metric alert"
  message             = "SMS budget is at risk of being exceeded ${var.runbooks["sms_budget"]} ${var.notify} "
  query               = "avg(last_1h):avg:aws.sns.smsmonth_to_date_spent_usd{region:${element(var.regions, count.index)}} by {organization} > ${var.sms_spend_limit_critical}"
  notify_no_data      = false
  require_full_window = true
  renotify_interval   = 20
  evaluation_delay    = 900
  tags                = var.tags
  count               = length(var.regions)

  monitor_thresholds {
    critical = var.sms_spend_limit_critical
    warning  = var.sms_spend_limit_warning
  }
}
