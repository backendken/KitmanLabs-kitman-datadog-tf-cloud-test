terraform {
  required_providers {
    datadog = {
      source  = "DataDog/datadog"
      version = "~> 3.0"
    }
  }
  
  cloud {
    organization = "kitman-cloud-test"
    
    workspaces {
      name = "datadog-us1-sandbox-simple-test"
    }
  }
}

provider "datadog" {
  # API and APP keys are set via environment variables
  # DATADOG_API_KEY and DATADOG_APP_KEY
}

resource "datadog_monitor" "test_monitor" {
  name    = "[sandbox] Test Monitor for Terraform Cloud"
  type    = "metric alert"
  message = "This is a test monitor created by Terraform Cloud @slack-eng-kitman-alarms-p1"
  query   = "avg(last_5m):avg:system.cpu.idle{*} by {host} < 10"
  
  tags = ["terraform", "test", "terraform-cloud"]
  
  monitor_thresholds {
    critical = 10
    warning  = 20
  }
  
  notify_no_data      = false
  require_full_window = false
  renotify_interval   = 20
}
