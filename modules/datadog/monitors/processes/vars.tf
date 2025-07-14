variable "tags" {
  description = "Tags set at the top level to indicate that this is managed by terraform and the version of kitman-datadog that created this alert"
  type        = list(string)
}

variable "environment" {
  description = "The environment production / staging / sandbox"
  type        = string
}

variable "notify" {
  description = "Who to notify, this can be a user tag or Slack channel"
  type        = string
}

variable "runbooks" {
  type = map(any)

  default = {
    shoryuken_process_count_too_high = "https://github.com/KitmanLabs/projects/tree/master/engineering/runbook_alarms/shoryuken_process_count_too_high.md"
    shoryuken_process_count_too_low  = "https://github.com/KitmanLabs/projects/tree/master/engineering/runbook_alarms/shoryuken_process_count_too_low.md"
  }
}

variable "shoryuken_process_count_threshold" {
  description = "Trigger an alarm when process_count for shoryuken processes is not equal to this value"
}
