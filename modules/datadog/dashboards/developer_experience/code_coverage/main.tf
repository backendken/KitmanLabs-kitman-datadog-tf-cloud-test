resource "datadog_dashboard" "code_coverage" {
  title            = "[TF] Code Coverage"
  description      = "Dashboard managed by Terraform"
  layout_type      = "ordered"
  restricted_roles = []

  widget {
    timeseries_definition {
      title = "Code Coverage over Time"

      request {
        q            = "avg:developerexperience.code_coverage{stack:fenway}"
        display_type = "line"

        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
      }

      request {
        q            = "avg:developerexperience.code_coverage{stack:headliner-ios}"
        display_type = "line"

        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
      }

      request {
        q            = "avg:developerexperience.code_coverage{stack:kitman-anailis}"
        display_type = "line"

        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
      }

      request {
        q            = "avg:developerexperience.code_coverage{stack:kitman-athlete-app-api}"
        display_type = "line"

        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
      }

      request {
        q            = "avg:developerexperience.code_coverage{stack:kitman-objc}"
        display_type = "line"

        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
      }

      request {
        q            = "avg:developerexperience.code_coverage{stack:medinah}"
        display_type = "line"

        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
      }

      request {
        q            = "avg:developerexperience.code_coverage{stack:sports-science-dashboard}"
        display_type = "line"

        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
      }
    }
  }
}
