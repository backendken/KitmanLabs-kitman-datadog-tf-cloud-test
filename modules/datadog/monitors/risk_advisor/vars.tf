variable "tags" {
  description = "Tags set at the top level to indicate that this is managed by terraform and the version of kitman-datadog that created this alert"
  type        = list(string)
}

variable "environment" {
  description = "The environment production / staging / sandbox"
  type        = string
}

variable "accounts" {
  type = map(string)
}

variable "regions" {
  description = "The regions that this alarm will be applied to"
  type        = list(string)
}

variable "notify" {
  description = "Who to notify, this can be a user tag or Slack channel"
  type        = string
}

variable "runbook" {
  description = "Provide a link to a runbook"
  default     = "https://github.com/KitmanLabs/projects/tree/master/engineering/runbook_alarms/risk_advisor_step_functions.md"
}
