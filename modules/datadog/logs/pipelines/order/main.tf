resource "datadog_logs_pipeline_order" "pipeline_order" {
  name = "pipeline_order"

  pipelines = var.pipeline_ids
}
