resource "datadog_monitor" "fleet_cpu_monitor" {
  name = "[${var.environment}] - [${element(var.regions, count.index)}] Fleet High CPU Alarm"
  type = "metric alert"

  message = <<EOM
High CPU!! across the entire {{app.name}} fleet

We've detected high CPU usage which has not been addressed by auto-scaling.
* Runbook: ${var.runbooks["app_fleet_cpu_monitor"]}
* View fleet in [Datadog](https://app.datadoghq.com/infrastructure?tags=app:{{app.name}}%2Cenvironment%3A${var.environment}%2Cregion%3A${element(var.regions, count.index)})
* View the Autoscaling Dashboard in [Datadog](https://app.datadoghq.com/screen/integration/204/aws-auto-scaling?tpl_var_autoscaling_group={{autoscalinggroupname.name}})
* View ASG monitoring details in the [AWS Console](https://${element(var.regions, count.index)}.console.aws.amazon.com/ec2autoscaling/home?region=eu-west-1#/details/{{autoscalinggroupname.name}}?view=monitoring)
  
Notify: ${var.notify}
EOM

  query             = "avg(last_15m):min:system.cpu.idle{environment:${var.environment},region:${element(var.regions, count.index)},!${join(",!", var.exclude_params)}} by {autoscaling_group,app} + ((min:aws.autoscaling.group_max_size{environment:${var.environment},region:${element(var.regions, count.index)},!${join(",!", var.exclude_params)}} by {autoscaling_group,app} - max:aws.autoscaling.group_in_service_instances{environment:${var.environment},region:${element(var.regions, count.index)},!${join(",!", var.exclude_params)}} by {autoscaling_group,app}) * 100) < ${var.cpu_idle_threshold}"
  no_data_timeframe = var.no_data_timeframe

  monitor_thresholds {
    critical = var.cpu_idle_threshold
  }

  notify_no_data      = false
  require_full_window = true
  renotify_interval   = 20
  new_group_delay     = var.new_group_delay
  count               = length(var.regions)
  evaluation_delay    = 900
  tags                = var.tags
}
