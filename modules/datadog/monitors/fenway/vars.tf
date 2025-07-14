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

variable "runbooks" {
  type = map(any)

  default = {
    fenway_process_time           = "https://github.com/KitmanLabs/projects/tree/master/engineering/runbook_alarms/fenway_process_time.md"
    elasticsearch_memory_pressure = "https://github.com/KitmanLabs/projects/blob/master/engineering/runbook_alarms/elasticsearch_memory_pressure.md"
    elasticsearch_cluster_status  = "https://github.com/KitmanLabs/projects/tree/master/engineering/runbook_alarms/elasticsearch_cluster_status.md"
    elasticsearch_blocked_writes  = "https://github.com/KitmanLabs/projects/tree/master/engineering/runbook_alarms/elasticsearch_blocked_writes.md"
    dynamodb_throttled            = "https://github.com/KitmanLabs/projects/tree/master/engineering/runbook_alarms/dynamodb_throttled.md"
  }
}

variable "threshold" {
  description = "Process time threshold in ms"
  default     = "120000"
}

variable "elasticsearch_gc_critical_threshold" {
  description = "This is the percentage threshold above which the ES node is spending most of its time doing garbage collection and can potentially take down the whole node"
  default     = "85"
}

variable "elasticsearch_gc_warning_threshold" {
  description = "This is the percentage threshold above which the ES node will start spending too much time executing garbage collection"
  default     = "75"
}
