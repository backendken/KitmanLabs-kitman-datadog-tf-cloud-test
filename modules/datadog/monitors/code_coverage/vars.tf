variable "tags" {
  description = "Tags set at the top level to indicate that this is managed by terraform and the version of kitman-datadog that created this alert"
  type        = list(string)
}

variable "notify" {
  description = "Who to notify, this can be a user tag or Slack channel"
  type        = string
}

variable "runbooks" {
  type = map(any)

  default = {
    code_coverage = "https://github.com/KitmanLabs/projects/tree/master/engineering/runbook_alarms/code_coverage.md"
  }
}

variable "default_runbook" {
  default = "https://github.com/KitmanLabs/projects/tree/master/engineering/runbook_alarms/code_coverage.md"
}

variable "stacks" {
  type = map(string)

  default = {
    fenway                   = "94.43"
    medinah                  = "93.86"
    kitman-athlete-app-api   = "93.78"
    kitman-anailis           = "93.18"
    sports-science-dashboard = "81.6"
    kitman-objc              = "43.03"
    headliner-ios            = "30.81"
  }
}
