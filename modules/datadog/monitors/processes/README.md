# Processes

## ALARM DESCRIPTION

Alarms that monitor the number of processes matching a specific string. This is
used to ensure processes are up and monit hasn't fallen over.

- Shoryuken

### Usage

This module needs very little configuration. Set the number of expected processes per host using the vars.


### Known Issues

Until we upgrade to Terraform 0.10.7 Terraform will incorrectly attempt to modify certain monitors

```
~ module.analyser_production.datadog_monitor.analyser_monitor_failure
    type: "query alert" => "metric alert"
```

https://github.com/hashicorp/terraform/issues/13784
