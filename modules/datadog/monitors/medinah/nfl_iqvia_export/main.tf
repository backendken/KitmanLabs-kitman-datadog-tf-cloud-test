resource "datadog_monitor" "nfl_iqvia_export_failure" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] NFL IQVIA Export Failure"
  type               = "event-v2 alert"
  message            = "{{#is_alert}}An NFL IQVIA exporter has failed. This will not prevent delivery of files to IQVIA but could mean some data will be missing if the single retry also failed. This should be investigated.{{/is_alert}} ${var.notify}"
  query              = "events(\"environment:${var.environment} region:${element(var.regions, count.index)} task_family:medinah_export_migratable_csv @title:\\\"Migratable CSV Export Failure\\\"\").index(\"*\").rollup(\"count\").last(\"5m\") > 0"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}

resource "datadog_monitor" "nfl_iqvia_export_delivery_failure" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] NFL IQVIA Export Delivery Failure"
  type               = "event-v2 alert"
  message            = "{{#is_alert}}The delivery of NFL data to IQVIA has failed. This needs investigating ASAP to ensure we don't violate our SLA.{{/is_alert}} ${var.notify}"
  query              = "events(\"environment:${var.environment} region:${element(var.regions, count.index)} task_family:medinah_export_migratable_csv @title:\\\"NFL IQVIA export delivery failure\\\"\").index(\"*\").rollup(\"count\").last(\"5m\") > 0"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}

resource "datadog_monitor" "nfl_iqvia_export_delivery_skipped" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] NFL IQVIA Export Delivery Skipped"
  type               = "event-v2 alert"
  message            = "{{#is_alert}}The delivery of NFL data to IQVIA was skipped (likely due to no data being present or data from an incorrect organisation being included). This should be investigated ASAP as this is unusual, especially in production.{{/is_alert}} ${var.notify}"
  query              = "events(\"environment:${var.environment} region:${element(var.regions, count.index)} task_family:medinah_export_migratable_csv @title:\\\"NFL IQVIA export delivery skipped\\\"\").index(\"*\").rollup(\"count\").last(\"5m\") > 0"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}

resource "datadog_monitor" "nfl_iqvia_export_delivery_overdue" {
  name    = "[${var.environment}] - [${element(var.regions, count.index)}] NFL IQVIA Export Overdue"
  type    = "event-v2 alert"
  message = "{{#is_alert}}Today's production NFL IQVIA export has not yet completed and it would normally be complete by now (7am UTC, 8am BST). This could indicate a soft-failure of the process and should be investigated ASAP. It could also indicate that the export is just taking longer than usual and the reason for this should be investigated or this monitor adjusted to give the export more time to complete before raising the alarm.{{/is_alert}} ${var.notify}"
  query   = "events(\"environment:${var.environment} region:${element(var.regions, count.index)} task_family:medinah_export_migratable_csv @title:\\\"NFL IQVIA export delivery complete\\\"\").index(\"*\").rollup(\"count\").current(\"1d\") < 1"
  scheduling_options {
    evaluation_window {
      day_starts = "04:00"
    }
    custom_schedule {
      recurrence {
        rrule    = "FREQ=DAILY;INTERVAL=1;BYHOUR=8;BYMINUTE=15"
        timezone = "UTC"
      }
    }
  }
  enable_logs_sample = true
  tags               = var.tags
  count              = var.environment == "production" ? length(var.regions) : 0
}