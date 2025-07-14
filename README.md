# kitman-datadog

This repository automates our Datadog Terraform.

It differs from our typical Terragrunt pattern in that the modules live directly in this repo, which allows for much quicker and easier updating of the Datadog Terraform.

Due to the simplicity of kitman-datadog we use a newer version of terragrunt and terraform than our elon / elon-modules setup, you should not need Docker to run plan and apply on this repository.

## Folder Structure

The structure of Datadog Terraform/Terragrunt is based on the Datadog sites we use; for example, our commercial Kitman Labs Datadog service uses the **US1**, whereas the FedRAMP Government Kitman Labs services use the Datadog **US1-FED**.

The site-based organisation allows us to expand into other Datadog offerings, such as the **EU1** (Europe) or the Japanese site **AP1**, as required. Additionally, we can separate the FedRAMP Government to have its own security credentials, only allowing those with AWS GovCloud credentials to modify Datadog **US1-FED**.

## Usage

### Commercial

Within the **US1** folder, navigate to the module you wish to plan and apply your changes to, and run the following command:

```bash
aws-vault exec production-poweruser -- chamber exec datadog -- terragrunt plan
```

### Government

Within the **US1-FED** folder, navigate to the module you wish to plan and apply your changes to, and run the following command:

```bash
aws-vault exec govcloud-production-poweruser -- chamber exec datadog -- terragrunt plan
```

## Datadog Helper Scripts

In the bin directory there are scripts for manually interacting with the Datadog API. They can prove very useful for exporting
monitors and dashboards. It is typically much much easier to design the dashboard in the Datadog website. And just export the JSON.

Here is an example of grabbing the JSON for a dashboard with ID 929084

`aws-vault exec production-engineers -- chamber exec datadog -- ./get_dashboard.sh 929084`

You can use the JSON to create a datadog representation of the dashboard. Unfortunately there is no easy way to convert the JSON representation to HCL. The JSON representation is much more verbose and also many keys do not map 1-1 with the HCL representation of a Dashboard.
