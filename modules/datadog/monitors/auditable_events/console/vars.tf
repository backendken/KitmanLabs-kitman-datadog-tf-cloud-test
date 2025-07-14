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

variable "offering_type" {
  description = "Government or Commercial"
  type        = string
}
