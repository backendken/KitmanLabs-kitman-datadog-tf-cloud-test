terraform {
  cloud {
    organization = "kitman-cloud-test"
    
    workspaces {
      tags = ["datadog", "terragrunt"]
    }
  }
}