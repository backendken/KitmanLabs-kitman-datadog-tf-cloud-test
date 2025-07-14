terraform {
  cloud {
    organization = "YOUR_ORGANIZATION_NAME" # Replace with your org name
    
    workspaces {
      tags = ["datadog", "terragrunt"]
    }
  }
}