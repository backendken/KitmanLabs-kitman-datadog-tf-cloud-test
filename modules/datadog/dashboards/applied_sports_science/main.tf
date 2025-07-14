resource "datadog_dashboard" "applied_sports_science" {
  title            = "[TF] Applied Sports Science"
  layout_type      = "ordered"
  description      = "Dashboard managed by Terraform - do not edit as changes will be periodically overwritten - contact #team-eng-dub-platform on Slack to update"
  restricted_roles = []

  template_variable {
    name     = "organisation"
    prefix   = "organisation"
    defaults = ["*"]
  }

  template_variable {
    name     = "squad"
    prefix   = "squad"
    defaults = ["*"]
  }

  template_variable {
    name     = "user_id"
    prefix   = "user_id"
    defaults = ["*"]
  }

  template_variable {
    name     = "user_type"
    prefix   = "user_type"
    defaults = ["*"]
  }

  template_variable {
    name     = "user_role"
    prefix   = "user_role"
    defaults = ["*"]
  }

  template_variable {
    name     = "controller"
    prefix   = "controller"
    defaults = ["*"]
  }

  template_variable {
    name     = "action"
    prefix   = "action"
    defaults = ["*"]
  }

  template_variable {
    name     = "source"
    prefix   = "source"
    defaults = ["*"]
  }

  widget {
    timeseries_definition {
      title = "Capture Questionnaires Created"

      request {
        q            = "top(sum:athlete_api.production.completed_questionnaire.create{$source,$organisation,source:capture,$squad} by {organisation}.as_count(), 20, 'sum', 'desc')"
        display_type = "bars"

        style {
          palette    = "cool"
          line_type  = "solid"
          line_width = "normal"
        }
      }
    }
  }

  widget {
    toplist_definition {
      title = "Capture Questionnaires Created (Toplist)"

      request {
        q = "top(sum:athlete_api.production.completed_questionnaire.create{$source,$organisation,source:capture,$squad} by {organisation}.as_count(), 20, 'sum', 'desc')"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "Athlete App Questionnaires Created (Total)"

      request {
        q            = "sum:athlete_api.production.completed_questionnaire.create{$source,$organisation,source:athlete}.as_count()"
        display_type = "bars"
      }
    }
  }

  widget {
    toplist_definition {
      title = "Athlete App Questionnaires Created (by Org)"

      request {
        q = "top(sum:athlete_api.production.completed_questionnaire.create{$source,$organisation,source:athlete} by {organisation}.as_count(), 50, 'sum', 'desc')"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "3rd Party Upload (Use filters above to refine by Org & Vendor)"

      request {
        q            = "top(sum:fenway.production.metrics.import{$organisation,$source,$user_id} by {source}.as_count(), 50, 'sum', 'desc')"
        display_type = "bars"

        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
      }
    }
  }

  widget {
    toplist_definition {
      title = "3rd Party Upload (Use filters above to refine by Org & Vendor)"

      request {
        q = "top(sum:fenway.production.metrics.import{$organisation,$source,$user_id} by {source}.as_count(), 50, 'sum', 'desc')"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "Profiler Questionnaires Created"

      request {
        q            = "sum:medinah.controllers.status.200{$organisation,controller:questionnairescontroller,action:create,environment:production}.as_count()"
        display_type = "bars"

        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
      }
    }
  }

  widget {
    toplist_definition {
      title = "Individual Training Sessions created by Athletes (Athlete App)"

      request {
        q = "top(sum:athlete_api.production.training_session.create{$organisation} by {organisation}.as_count(), 10, 'sum', 'desc')"
      }
    }
  }

  widget {
    toplist_definition {
      title = "Injuries Created"

      request {
        q = "top(sum:medinah.controllers.status.200{$squad,$organisation,controller:athletes::injuryoccurrencescontroller,$user_type,action:create,environment:production} by {user_type}.as_count(), 50, 'sum', 'desc')"
      }
    }
  }

  widget {
    toplist_definition {
      title = "Illness Created"

      request {
        q = "top(sum:medinah.controllers.status.200{$squad,$organisation,$user_type,controller:athletes::illnessoccurrencescontroller,action:create,environment:production} by {user_type}.as_count(), 50, 'sum', 'desc')"
      }
    }
  }

  widget {
    toplist_definition {
      title = "Medical Notes Created"

      request {
        q = "top(sum:medinah.controllers.status.200{$squad,$organisation,$user_type,action:create,environment:production,controller:athletes::medicalnotescontroller} by {user_type}.as_count(), 50, 'sum', 'desc')"
      }
    }
  }

  widget {
    toplist_definition {
      title = "Diagnostics Created"

      request {
        q = "top(sum:medinah.controllers.status.200{$squad,$organisation,$user_type,action:create,environment:production,controller:athletes::diagnosticscontroller} by {user_type}.as_count(), 50, 'sum', 'desc')"
      }
    }
  }

  widget {
    toplist_definition {
      title = "Account Admin Logins"

      request {
        q = "top(sum:medinah.production.session.create{$organisation,user_type:account_admin,$squad} by {user_id}.as_count(), 50, 'sum', 'desc')"
      }
    }
  }

  widget {
    toplist_definition {
      title = "Profiler Staff Logins (By User)"

      request {
        q = "top(sum:medinah.production.session.create{$organisation,user_type:staff,$user_id,!organisation:kitman-staff,!organisation:kitman} by {user_id}.as_count(), 50, 'sum', 'desc')"
      }
    }
  }

  widget {
    toplist_definition {
      title = "Profiler Staff Logins (by Org)"

      request {
        q = "top(sum:medinah.production.session.create{$organisation,user_type:staff,!organisation:kitman-staff,!organisation:kitman} by {organisation}.as_count(), 50, 'sum', 'desc')"
      }
    }
  }

  widget {
    toplist_definition {
      title = "Training Sessions created by Staff (Profiler)"

      request {
        q = "top(sum:medinah.controllers.status.200{controller:workloads::importworkflowcontroller,action:perform,environment:production,!user_type:super_admin,!organisatin:kitman,!organisatin:kitman-staff,$organisation,$user_id,$squad,$user_role} by {organisation,squad}.as_count(), 50, 'sum', 'desc')"
      }
    }
  }

  widget {
    toplist_definition {
      title = "Headliner Logins (First Time)"

      request {
        q = "top(sum:athlete_api.production.session.create{source:headliner} by {user_id}.as_count(), 50, 'sum', 'desc')"
      }
    }
  }

  widget {
    toplist_definition {
      title = "Profiler Failed Logins (by User)"

      request {
        q = "top(sum:medinah.production.session.invalid_password{$organisation,$source,$user_id,!user_type:super_admin,!organisation:kitman-staff,!organisation:kitman} by {user_id}.as_count(), 50, 'sum', 'desc')"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "Profiler (Medinah) Staff Logins (By Org and User)"

      request {
        q            = "sum:medinah.production.session.create{$organisation,user_type:staff,$user_id,!organisation:kitman-staff,!organisation:kitman} by {organisation,user_id}.as_count()"
        display_type = "bars"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "Profiler Staff Logins (By Org and User)"

      request {
        q            = "sum:medinah.production.session.create{$organisation,user_type:staff,$user_id,!organisation:kitman-staff,!organisation:kitman} by {organisation,user_id}.as_count()"
        display_type = "bars"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "Profiler Failed Login - Password"

      request {
        q            = "top(sum:medinah.production.session.invalid_password{*}.as_count(), 50, 'sum', 'desc')"
        display_type = "bars"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "Profiler Max page load times (95% - timeseries)"

      request {
        q            = "top(max:medinah.production.performance.total_duration.95percentile{$controller,$action,$squad,$organisation} by {controller}, 10, 'max', 'desc')"
        display_type = "bars"
      }
    }
  }

  widget {
    toplist_definition {
      title = "Profiler Max page load times (95% - toplist)"

      request {
        q = "top(max:medinah.production.performance.total_duration.95percentile{$controller,$action,$squad,$organisation} by {controller}, 50, 'max', 'desc')"
      }
    }
  }

  widget {
    toplist_definition {
      title = "Profiler Staff Logins"

      request {
        q = "top(sum:medinah.production.session.create{$organisation,user_type:staff,!organisation:kitman-staff,!organisation:kitman} by {organisation}.as_count(), 50, 'max', 'desc')"
      }
    }
  }
}
