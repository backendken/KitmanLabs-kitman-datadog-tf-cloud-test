variable "runbooks" {
  type = map(string)

  default = {
    crash                             = "https://github.com/KitmanLabs/projects/tree/master/engineering/runbook_alarms/athlete_api_crash.md"
    completed_questionnaire_processor = "https://github.com/KitmanLabs/projects/tree/master/engineering/runbook_alarms/athlete_api_completed_questionnaire_processor.md"
    completed_questionnaire_dlq       = "https://github.com/KitmanLabs/projects/tree/master/engineering/runbook_alarms/athlete_api_completed_questionnaire_dlq.md"
    sms_failures                      = "https://github.com/KitmanLabs/projects/tree/master/engineering/runbook_alarms/athlete_api_sms_failures.md"
    sms_budget                        = "https://github.com/KitmanLabs/projects/tree/master/engineering/runbook_alarms/sms_budget.md"
  }
}

variable "crash_threshold" {
  description = "How many crashes are acceptable in a 24 hour period"
  default     = "10"
}

variable "smssuccess_critical_rate" {
  description = "At what rate should we error for SMS failures?"
  default     = "0.8"
}

variable "smssuccess_warning_rate" {
  description = "At what rate should we warn for SMS failures?"
  default     = "0.95"
}

variable "sms_spend_limit_critical" {
  description = "At what limit should we error about SMS budget?"
  default     = "150"
}

variable "sms_spend_limit_warning" {
  description = "At what limit should we warn about SMS budget?"
  default     = "50"
}

variable "tags" {
  description = "Tags set at the top level to indicate that this is managed by terraform and the version of kitman-datadog that created this alert"
  type        = list(string)
}

variable "environment" {
  description = "The environment production / staging / sandbox"
  type        = string
}

variable "regions" {
  description = "The regions that this alarm will be applied to"
  type        = list(string)
}

variable "notify" {
  description = "Who to notify, this can be a user tag or Slack channel"
  type        = string
}
