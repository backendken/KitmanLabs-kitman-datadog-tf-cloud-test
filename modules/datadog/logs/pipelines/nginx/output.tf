output "nginx_id" {
  value = datadog_logs_integration_pipeline.nginx.id
}

output "nginx_kitman_id" {
  value = datadog_logs_custom_pipeline.nginx_kitman.id
}
