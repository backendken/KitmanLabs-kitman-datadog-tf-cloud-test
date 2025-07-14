variable "notify" {
  description = "Who you want to notify"
}

variable "runbooks" {
  type = map(any)

  default = {
    app_fleet_cpu_monitor = "https://github.com/KitmanLabs/projects/tree/master/engineering/runbook_alarms/app_fleet_cpu_monitor.md"
  }
}

variable "cpu_idle_threshold" {
  description = "This is a low threshold, We will alarm if lower than this value. Valid range 0-100"
  default     = "20"
}

variable "new_group_delay" {
  default     = 1800
  description = "How long in seconds to wait before evaluating new hosts, This is important as high CPU is expected at boot"
}

variable "environment" {
  description = "Only apply the alarm to hosts that have this environment tag"
}

variable "no_data_timeframe" {
  description = "The number of minutes before a monitor notifies after data stops reporting"
  default     = 0
}

variable "regions" {
  type = list(any)
}

variable "exclude_params" {
  description = "Exclude known high load apps"
  type        = list(any)
  default     = ["app:multivariate", "app:remix", "app:fusion"]
}

variable "tags" {
  description = "Tags set at the top level to indicate that this is managed by terraform and the version of kitman-datadog that created this alert"
  type        = list(string)
}
