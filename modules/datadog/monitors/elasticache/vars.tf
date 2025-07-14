variable "tags" {
  description = "Tags set at the top level to indicate that this is managed by terraform and the version of kitman-datadog that created this alert"
  type        = list(string)
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
  type        = map(any)

  default = {
    cpuutilization = "https://github.com/KitmanLabs/projects/blob/master/engineering/runbook_alarms/elasticache_cpu.md"
    evictions      = "https://github.com/KitmanLabs/projects/blob/master/engineering/runbook_alarms/elasticache_evictions.md"
  }
}
