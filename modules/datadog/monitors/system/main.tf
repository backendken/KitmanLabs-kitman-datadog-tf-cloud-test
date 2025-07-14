resource "datadog_monitor" "system_cpu_monitor_" {
  name = "[${var.environment}] - [${element(var.regions, count.index)}] Catch All High CPU Alarm"
  type = "metric alert"

  message = <<EOM
High CPU!! on {{host.name}} ({{host.app}}) in {{host.region}}

* Runbook: ${var.runbooks["system_cpu_monitor"]}
* View host in Datadog: https://app.datadoghq.com/infrastructure?tab=details&host={{host.name}}
* View host processes in Datadog: https://app.datadoghq.com/process?query=host:{{host.name}}

Notify: ${var.notify}
EOM

  query             = "avg(last_15m):max:aws.ec2.cpuutilization{region:${element(var.regions, count.index)},environment:${var.environment},!${join(",!", var.host_excludes)}} by {host} > ${var.cpu_threshold}"
  no_data_timeframe = var.no_data_timeframe

  monitor_thresholds {
    critical = var.cpu_threshold
  }

  notify_no_data      = false
  require_full_window = false
  renotify_interval   = 20
  new_group_delay     = var.new_group_delay
  count               = length(var.regions)
  tags                = var.tags
}

resource "datadog_monitor" "system_load_monitor" {
  name = "[${var.environment}] - [${element(var.regions, count.index)}] Catch All High Load Alarm"
  type = "metric alert"

  message = <<EOM
High Load!! on {{host.name}} ({{host.app}}) in {{host.region}}

* Runbook: ${var.runbooks["system_load_monitor"]}
* View host in Datadog: https://app.datadoghq.com/infrastructure?tab=details&host={{host.name}}
* View host processes in Datadog: https://app.datadoghq.com/process?query=host:{{host.name}}

Notify: ${var.notify}
EOM

  query               = "avg(last_15m):max:system.load.norm.5{region:${element(var.regions, count.index)},environment:${var.environment},!${join(",!", var.host_excludes)}} by {host} > ${var.load_threshold}"
  no_data_timeframe   = 30
  notify_no_data      = false
  require_full_window = false
  renotify_interval   = 20
  new_group_delay     = var.new_group_delay
  count               = length(var.regions)
  tags                = var.tags
}

resource "datadog_monitor" "system_disk_monitor" {
  name = "[${var.environment}] - [${element(var.regions, count.index)}] Catch All High Disk Usage Alarm"
  type = "metric alert"

  message = <<EOM
Disk is > 80% full!! on {{host.name}} ({{host.app}}) in {{host.region}}

* Runbook: ${var.runbooks["system_disk_monitor"]}
* View host in Datadog: https://app.datadoghq.com/infrastructure?tab=details&host={{host.name}}

Notify: ${var.notify}
EOM

  query               = "max(last_5m):max:system.disk.in_use{region:${element(var.regions, count.index)},environment:${var.environment},!${join(",!", var.host_excludes)}} by {host} > ${var.disk_threshold}"
  no_data_timeframe   = 30
  notify_no_data      = false
  require_full_window = false
  renotify_interval   = 20
  count               = length(var.regions)
  tags                = var.tags
}

resource "datadog_monitor" "system_memory_monitor" {
  name = "[${var.environment}] - [${element(var.regions, count.index)}] Catch All Low Memory Alarm"
  type = "metric alert"

  message = <<EOM
Less than {{eval "var.memory_threshold * 100"}}% Usable Memory on {{host.name}} ({{host.app}}) in {{host.region}}

* Runbook: ${var.runbooks["system_memory_monitor"]}
* View host in Datadog: https://app.datadoghq.com/infrastructure?tab=details&host={{host.name}}

Notify: ${var.notify}
EOM

  query               = "max(last_5m):max:system.mem.pct_usable{region:${element(var.regions, count.index)},environment:${var.environment},!${join(",!", var.host_excludes)}} by {host} < ${var.memory_threshold}"
  no_data_timeframe   = 30
  notify_no_data      = false
  require_full_window = false
  renotify_interval   = 20
  count               = length(var.regions)
  tags                = var.tags
}

resource "datadog_monitor" "system_elb_latency" {
  name = "[${var.environment}] - [${element(var.regions, count.index)}] Catch All High ELB Latency"
  type = "metric alert"

  message = <<EOM
Latency for targetgroup: {{targetgroup.name}} is > ${var.latency_threshold}

* Runbook: ${var.runbooks["system_elb_latency"]}
* View slow request logs in [Datadog Logs](https://app.datadoghq.com/logs?cols=log_path%2Clog_status%2C%40duration&query=region%3A${element(var.regions, count.index)}%20environment%3A${var.environment}%20source%3Arails%20sourcecategory%3Arails_requests%20%40duration%3A%3E${var.latency_threshold * 1000})
* Cloudwatch Logs: https://${element(var.regions, count.index)}.aws.amazon.com/cloudwatch/home

Notify: ${var.notify}
EOM

  query               = "min(last_15m):max:aws.applicationelb.target_response_time.maximum{region:${element(var.regions, count.index)},environment:${var.environment}} by {targetgroup} > ${var.latency_threshold}"
  no_data_timeframe   = 30
  notify_no_data      = false
  require_full_window = false
  renotify_interval   = var.environment == "production" ? 20 : 0                                                    # Only renotify in production
  timeout_h           = var.environment == "production" && element(var.regions, count.index) == "eu-west-1" ? 0 : 1 # Auto-resolve monitors outside EU production as we may not have traffic to do it in staging
  count               = length(var.regions)
  tags                = var.tags
}

resource "datadog_monitor" "system_elb_5xx" {
  name = "[${var.environment}] - [${element(var.regions, count.index)}] Catch all ELB 5XX"
  type = "metric alert"

  message = <<EOM
5xx Errors for targetgroup: {{targetgroup.name}} is > ${var.error_threshold}

* Runbook: ${var.runbooks["system_elb_5xx"]}
* View 5xx logs in [Datadog Logs](https://app.datadoghq.com/logs?cols=log_path%2Clog_status%2C%40duration&query=region%3A${element(var.regions, count.index)}%20environment%3A${var.environment}%20source%3Arails%20sourcecategory%3Arails_requests%20%40status%3A500)
* Cloudwatch: https://${element(var.regions, count.index)}.aws.amazon.com/cloudwatch/home
* EC2 Console: https://${element(var.regions, count.index)}.console.aws.amazon.com/ec2/v2/home?region=${element(var.regions, count.index)}#TargetGroups:

Notify: ${var.notify}
EOM

  query = "sum(last_15m):sum:aws.applicationelb.httpcode_target_5xx{region:${element(var.regions, count.index)},environment:${var.environment}} by {targetgroup}.as_count() >= ${var.error_threshold}"

  monitor_thresholds {
    critical = var.error_threshold
  }

  notify_no_data      = false
  require_full_window = true
  evaluation_delay    = 900
  renotify_interval   = var.environment == "production" ? 20 : 0 # Only renotify in production
  timeout_h           = var.environment != "production" ? 1 : 0  # Auto-resolve monitors outside production as we may not have traffic to do it in staging
  count               = length(var.regions)
  tags                = var.tags
}

resource "datadog_monitor" "low_healthy_hosts" {
  name = "[${var.environment}] - [${element(var.regions, count.index)}] Less than ${var.hosts_threshold} hosts in a target group"
  type = "metric alert"

  message = <<EOM
Less than ${var.hosts_threshold} in targetgroup: {{targetgroup.name}}

* Runbook: ${var.runbooks["low_healthy_hosts"]}
* Console: https://${element(var.regions, count.index)}.console.aws.amazon.com/ec2/v2/home?region=${element(var.regions, count.index)}#TargetGroups:

Notify: ${var.notify}
EOM

  query = "max(last_15m):sum:aws.applicationelb.healthy_host_count{region:${element(var.regions, count.index)},environment:${var.environment}${length(var.includes) > 0 ? "," : ""}${join(",", var.includes)},!${join(",!", var.elb_excludes)}} by {targetgroup} < ${var.hosts_threshold}"

  monitor_thresholds {
    critical = var.hosts_threshold
  }

  notify_no_data      = false
  require_full_window = false
  renotify_interval   = 20
  count               = length(var.regions)
  tags                = var.tags
}

resource "datadog_monitor" "asg_instance_count_monitor" {
  name = "[${var.environment}] - [${element(var.regions, count.index)}] Autoscaling Group at Max Instances Alarm"
  type = "metric alert"

  message = <<EOM
The {{app.name}} ASG has had 0 spare instances for at least the last ${var.asg_lookback_timeframe} minutes.

* Runbook: ${var.runbooks["system_instance_count_monitor"]}
* View app hosts in [Datadog](https://app.datadoghq.com/infrastructure?tab=details&tags=app:{{app.name}},region:${element(var.regions, count.index)},environment:${var.environment})
* View the Autoscaling Dashboard in [Datadog](https://app.datadoghq.com/screen/integration/204/aws-auto-scaling?tpl_var_autoscaling_group={{autoscalinggroupname.name}})
* View ASG monitoring details in the [AWS Console](https://${element(var.regions, count.index)}.console.aws.amazon.com/ec2autoscaling/home?region=eu-west-1#/details/{{autoscalinggroupname.name}}?view=monitoring)

Notify: ${var.notify}
EOM

  query               = "max(last_${var.asg_lookback_timeframe}m):sum:aws.autoscaling.group_max_size{environment: ${var.environment}, region: ${element(var.regions, count.index)}, !app:athlete-api-worker, !app:mlkit} by {app,autoscalinggroupname} - sum:aws.autoscaling.group_total_instances{environment: ${var.environment}, region: ${element(var.regions, count.index)}, !app:athlete-api-worker, !app:mlkit} by {app,autoscalinggroupname} <= 0"
  no_data_timeframe   = var.no_data_timeframe
  notify_no_data      = false
  require_full_window = false
  renotify_interval   = 20
  count               = length(var.regions)
  tags                = var.tags
}
