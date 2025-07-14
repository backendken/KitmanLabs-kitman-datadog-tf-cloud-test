resource "datadog_dashboard" "batch_fusion" {
  title            = "[TF] Batch Fusion / Remix etc"
  description      = "Dashboard managed by Terraform"
  layout_type      = "ordered"
  restricted_roles = []

  template_variable {
    defaults = ["production"]
    prefix   = "organization"
    name     = "aws_organization"
  }

  widget {
    timeseries_definition {
      title = "Backend Production Memory"

      request {
        q            = "max:system.mem.usable{name:backend_production}"
        display_type = "line"
      }

      request {
        q            = "max:system.mem.used{name:backend_production}"
        display_type = "line"
      }

      request {
        q            = "max:system.mem.free{name:backend_production}"
        display_type = "line"
      }

      request {
        q            = "max:system.mem.total{name:backend_production}"
        display_type = "line"
      }
    }
  }

  widget {
    hostmap_definition {
      title = "Fusion ECS Instances"

      request {
        fill {
          q = "max:system.mem.usable{name:backend_production}"
        }
      }

      style {
        palette = "green_to_orange"
      }

      node_type       = "container"
      group           = ["instance-type"]
      no_group_hosts  = true
      no_metric_hosts = true
      scope           = ["region:us-east-1", "aws_account:727006795293"]
    }
  }

  widget {
    timeseries_definition {
      title = "Backend Production CPU"

      request {
        q            = "max:aws.ec2.cpuutilization{name:backend_production}"
        display_type = "line"
      }

      request {
        q            = "max:system.cpu.user{name:backend_production}"
        display_type = "line"
      }

      request {
        q            = "max:system.cpu.user{name:backend_production}"
        display_type = "line"
      }

      request {
        q            = "max:system.cpu.system{name:backend_production}"
        display_type = "line"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "Fenway Requests from Fusion"

      request {
        q            = "max:aws.elb.request_count{host:internal-fenway-fusion-elb-628785032.eu-west-1.elb.amazonaws.com}.as_count()"
        display_type = "bars"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "Backend Production Load"

      request {
        q = "max:system.load.1{name:backend_production}"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "Fusion EBS ops"

      request {
        q            = "avg:aws.ebs.volume_read_ops{app:fusion,$aws_organization}.as_count()"
        display_type = "bars"
      }

      request {
        q            = "avg:aws.ebs.volume_write_ops{app:fusion,$aws_organization}.as_count()"
        display_type = "bars"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "Remix EBS ops"

      request {
        q            = "avg:aws.ebs.volume_read_ops{app:remix,$aws_organization}.as_count()"
        display_type = "bars"
      }

      request {
        q            = "avg:aws.ebs.volume_write_ops{app:remix,$aws_organization}.as_count()"
        display_type = "bars"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "ECS CPU Utilization"

      request {
        q = "avg:aws.ecs.cpuutilization{$aws_organization}"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "Batch Running VS Pending Jobs"

      request {
        q            = "sum:aws.ecs.running_tasks_count{$aws_organization}"
        display_type = "line"
      }

      request {
        q            = "sum:aws.ecs.pending_tasks_count{$aws_organization}"
        display_type = "line"
      }

      request {
        q            = "sum:aws.ecs.pending_tasks_count{$aws_organization}"
        display_type = "line"
      }
    }
  }

  widget {
    query_value_definition {
      title     = "ECS Running Tasks"
      autoscale = true

      request {
        q          = "sum:aws.ecs.running_tasks_count{$aws_organization}"
        aggregator = "avg"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "Spot Fulfilled Capacity"

      request {
        q            = "max:aws.ec2spot.fulfilled_capacity{$aws_organization}.as_count().rollup(avg, 1200)"
        display_type = "bars"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "Estimated Daily Charges"

      request {
        q            = "avg:aws.billing.estimated_charges{$aws_organization}"
        display_type = "line"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "DynamoDB Stats"

      request {
        q            = "max:aws.dynamodb.consumed_read_capacity_units{tablename:fenway_production}"
        display_type = "line"
      }

      request {
        q            = "max:aws.dynamodb.consumed_write_capacity_units{tablename:fenway_production}"
        display_type = "line"
      }

      request {
        q            = "avg:aws.dynamodb.provisioned_read_capacity_units{tablename:fenway_production}"
        display_type = "line"

        style {
          line_type = "dashed"
        }
      }

      request {
        q            = "avg:aws.dynamodb.provisioned_write_capacity_units{tablename:fenway_production}"
        display_type = "line"

        style {
          line_type = "dashed"
        }
      }
    }
  }
}
