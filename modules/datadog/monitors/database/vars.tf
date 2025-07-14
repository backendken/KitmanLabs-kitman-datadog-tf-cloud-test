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
    cpu_monitor        = "https://github.com/KitmanLabs/projects/tree/master/engineering/runbook_alarms/aurora_cpu_monitor.md"
    backup_failed      = "https://github.com/KitmanLabs/projects/tree/master/engineering/runbook_alarms/aurora_backup_failed.md"
    backup_not_running = "https://github.com/KitmanLabs/projects/tree/master/engineering/runbook_alarms/aurora_backup_not_running.md"
    obfuscation_failed = "https://github.com/KitmanLabs/projects/tree/master/engineering/runbook_alarms/obfuscation_failed.md"
    restore_failed     = "https://github.com/KitmanLabs/projects/tree/master/engineering/runbook_alarms/restore_failed.md"
  }
}

variable "cpu_threshold" {
  description = "This is a high threshold, We are alarming if greater than this value. range 0-100"
  default     = "70"
}

variable "new_group_delay" {
  default     = 1800
  description = "How long to wait before evaluating new hosts, This is important as high CPU is expected at boot"
}

variable "includes" {
  type = list(any)

  default = [
    "engine:aurora",
    "name:profiler",
  ]
}

variable "excludes" {
  type = list(any)

  default = []
}


variable "backup_envs" {
  type    = list(any)
  default = ["production"]
}

variable "restore_envs" {
  type    = list(any)
  default = ["staging", "sandbox"]
}

variable "obfuscate_envs" {
  type    = list(any)
  default = ["production"]
}

variable "cpu_envs" {
  type    = list(any)
  default = ["production"]
}
