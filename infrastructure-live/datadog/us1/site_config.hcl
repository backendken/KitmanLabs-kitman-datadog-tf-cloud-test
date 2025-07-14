inputs = {
  offering_type = "Commercial"
  regions = [
    "eu-west-1",
    "us-east-1",
    "us-east-2",
  ]

  accounts = {
    "audit"      = "193927318370"
    "bastion"    = "319598741032"
    "images"     = "834914689975"
    "legacy"     = "152303373464"
    "production" = "499219461927"
    "sandbox"    = "011965355925"
    "staging"    = "688013719659"
    "terratest"  = "099844518908"
    "vpn"        = "135806132017"
  }
}

locals {
  datadog_site_code = basename(get_parent_terragrunt_dir())
  notify = {
    p0 = "@slack-eng-kitman-alarms"
    p1 = "@slack-eng-kitman-alarms-p1"
  }
}
