resource "datadog_logs_integration_pipeline" "nginx" {
  is_enabled = true
}

resource "datadog_logs_custom_pipeline" "nginx_kitman" {
  filter {
    query = "source:nginx"
  }

  name       = "Nginx - Kitman"
  is_enabled = true

  processor {
    attribute_remapper {
      sources              = ["status"]
      source_type          = "attribute"
      target               = "status"
      target_type          = "attribute"
      target_format        = "integer"
      preserve_source      = false
      override_on_conflict = false
      name                 = "Convert http status to integer"
      is_enabled           = true
    }
  }

  processor {
    attribute_remapper {
      sources              = ["duration"]
      source_type          = "attribute"
      target               = "duration"
      target_type          = "attribute"
      target_format        = "double"
      preserve_source      = false
      override_on_conflict = false
      name                 = "Convert duration to double"
      is_enabled           = true
    }
  }
}
