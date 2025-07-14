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
    system_cpu_monitor            = "https://github.com/KitmanLabs/projects/tree/master/engineering/runbook_alarms/system_cpu_monitor.md"
    system_load_monitor           = "https://github.com/KitmanLabs/projects/tree/master/engineering/runbook_alarms/system_load_monitor.md"
    system_disk_monitor           = "https://github.com/KitmanLabs/projects/tree/master/engineering/runbook_alarms/system_disk_monitor.md"
    system_memory_monitor         = "https://github.com/KitmanLabs/projects/tree/master/engineering/runbook_alarms/system_memory_monitor.md"
    system_elb_latency            = "https://github.com/KitmanLabs/projects/tree/master/engineering/runbook_alarms/system_elb_latency.md"
    system_elb_5xx                = "https://github.com/KitmanLabs/projects/tree/master/engineering/runbook_alarms/system_elb_5xx.md"
    low_healthy_hosts             = "https://github.com/KitmanLabs/projects/tree/master/engineering/runbook_alarms/low_healthy_hosts.md"
    app_fleet_cpu_monitor         = "https://github.com/KitmanLabs/projects/tree/master/engineering/runbook_alarms/app_fleet_cpu_monitor.md"
    system_instance_count_monitor = "https://github.com/KitmanLabs/projects/tree/master/engineering/runbook_alarms/system_autoscaling_instance_count_at_max.md"
  }
}

variable "cpu_threshold" {
  description = "This is a high threshold, We are alarming if greater than this value. range 0-100"
  default     = "75"
}

variable "load_threshold" {
  description = "This is a high threshold, We are alarming if greater than this value. range 0.0-1.0"
  default     = "0.75"
}

variable "disk_threshold" {
  description = "This is a high threshold, We are alarming if greater than this value. Range 0.0-1.0"
  default     = "0.8"
}

variable "memory_threshold" {
  description = "This is a low threshold, We are alarming if less than this percentage of memory is usable. Range 0.0-1.0"
  default     = "0.2"
}

variable "latency_threshold" {
  description = "This is a high threshold, We are alarming if latency is greater than this. 0.5 = 500ms"
  default     = "10"
}

variable "error_threshold" {
  description = "This is a high threshold, We are alarming if more than 15 errors in the past 15 minutes"
  default     = "15"
}

variable "hosts_threshold" {
  description = "This is a low threshold, We are alarming if we have less than this number of healthy hosts in a target group"
  default     = "2"
}

variable "new_group_delay" {
  default     = 1800
  description = "How long in seconds to wait before evaluating new hosts, This is important as high CPU is expected at boot"
}

variable "no_data_timeframe" {
  description = "The number of minutes before a monitor notifies after data stops reporting"
  default     = 0
}

variable "host_excludes" {
  description = "Exclude known high load machines"
  type        = list(any)
  default     = ["app:multivariate", "app:remix", "app:fusion"]
}

variable "includes" {
  description = "Include only certain accounts"
  type        = list(any)
  default     = []
}

variable "elb_excludes" {
  description = "Exclude the data science workloads as they don't have multiple hosts"
  type        = list(any)

  default = [
    "workload:datascience",
  ]
}

variable "asg_lookback_timeframe" {
  default     = "5"
  description = "How long (in minutes) should the asg instance count be at the maximum count before triggering"
}
