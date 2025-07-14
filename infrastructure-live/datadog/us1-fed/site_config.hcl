inputs = {
  offering_type = "Government"
  regions = [
    "us-gov-west-1"
  ]

  accounts = {
    "audit"      = "614497914326"
    "bastion"    = "609593927911"
    "images"     = "664760526764"
    "legacy"     = "492141866353"
    "production" = "664749818226"
    "sandbox"    = "622225855144"
    "staging"    = "664683507214"
  }
}

locals {
  datadog_site_code = basename(get_parent_terragrunt_dir())
  notify = {
    p0                  = "@slack-eng-kitman-alarms"
    p1                  = "@slack-eng-kitman-alarms-p1"
    govcloud_audit_team = "@adam@kitmanlabs.com"
  }
}
