# Description

**Related Github Issues / Pull Requests**
https://github.com/KitmanLabs/projects/issues/

## Checklist

- [ ] Rebase branch with master.
- [ ] `terragrunt run-all plan` for commercial (US1)
- [ ] `terragrunt run-all plan` for government (US1-FED)

You should see **no changes** from `terragrunt run-all plan` indicating your changes are all applied successfully and not effecting any other regions.

From the root of `kitman-datadog/infrastructure-live/datadog/us1` run the following command:

```bash
aws-vault exec production-poweruser -- chamber exec datadog -- terragrunt run-all plan
```

From the root of `kitman-datadog/infrastructure-live/datadog/us1-fed` run the following command:

```bash
aws-vault exec govcloud-production-poweruser -- chamber exec datadog -- terragrunt run-all plan
```

## Checklist Plans
<details>

<summary>US1</summary>

```bash
Output goes here...
```

</details>

<details>
<summary>US1-FED</summary>

```bash
Output goes here...
```

</details>
