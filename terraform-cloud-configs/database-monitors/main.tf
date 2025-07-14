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
      name = "datadog-us1-sandbox-database"
    }
  }
}

provider "datadog" {
  # API and APP keys are set via environment variables
  # DATADOG_API_KEY and DATADOG_APP_KEY
}

module "database_monitors" {
  source = "../../modules/datadog/monitors/database"
  
  # Environment configuration
  environment = "sandbox"
  
  # Region configuration
  regions = [
    "eu-west-1",
    "us-east-1",
    "us-east-2",
  ]
  
  # Notification configuration
  notify = "@slack-eng-kitman-alarms-p1"
  
  # Resource tags
  tags = ["terraform", "kitman-datadog v2.0"]
  
  # Database monitor specific variables
  cpu_threshold = "70"
  new_group_delay = 1800
  
  includes = [
    "engine:aurora",
    "name:profiler",
  ]
  
  excludes = []
  
  # Environment-specific settings
  backup_envs = ["production"]
  restore_envs = ["staging", "sandbox"]
  obfuscate_envs = ["production"]
  cpu_envs = ["production"]
}