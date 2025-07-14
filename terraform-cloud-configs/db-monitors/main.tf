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
      name = "datadog-us1-sandbox-db"
    }
  }
}

provider "datadog" {
  # API and APP keys are set via environment variables
  # DATADOG_API_KEY and DATADOG_APP_KEY
}

module "database_monitors" {
  source = "../../modules/datadog/monitors/database"
  
  # Environment configuration (matches sandbox)
  environment = "sandbox"
  
  # Region configuration (from site_config.hcl)
  regions = [
    "eu-west-1",
    "us-east-1",
    "us-east-2",
  ]
  
  # Notification configuration (from site_config.hcl)
  notify = "@slack-eng-kitman-alarms-p1"
  
  # Resource tags (from terragrunt.hcl)
  tags = ["terraform", "kitman-datadog v2.0"]
  
  # Database monitor specific variables (using defaults from vars.tf)
  cpu_threshold = "70"
  new_group_delay = 1800
  
  includes = [
    "engine:aurora",
    "name:profiler",
  ]
  
  excludes = []
  
  # Environment-specific settings (from vars.tf defaults)
  backup_envs = ["production"]        # sandbox NOT in here = no backup monitors
  restore_envs = ["staging", "sandbox"] # sandbox IS in here = will create restore monitors
  obfuscate_envs = ["production"]     # sandbox NOT in here = no obfuscation monitors
  cpu_envs = ["production"]           # sandbox NOT in here = no CPU monitors
}