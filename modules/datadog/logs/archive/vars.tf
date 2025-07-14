variable "environment" {
  type        = string
  description = "The environment to set up the log archive for"
}

variable "query" {
  type        = string
  description = "The query to use to filter out logs"
  default     = ""
}

variable "path" {
  type    = string
  default = "datadog_logs"
}

variable "role_name" {
  type    = string
  default = "datadog_role"
}

variable "accounts" {
  type = map(string)
}

variable "regions" {
  type = list(string)
}
