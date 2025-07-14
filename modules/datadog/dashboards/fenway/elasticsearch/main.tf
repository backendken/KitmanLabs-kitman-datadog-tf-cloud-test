resource "datadog_timeboard" "elastic_search_cluster_fenway" {
  title       = "[TF] Elasticsearch Cluster [Fenway]"
  description = "Dashboard managed by Terraform"
  read_only   = false

  template_variable {
    name    = "domain"
    prefix  = "domainname"
    default = "fenway-es-production"
  }

  graph {
    title     = "Cluster status"
    viz       = "query_value"
    autoscale = "true"

    request {
      q          = "avg:aws.es.cluster_statusgreen{$domain}"
      aggregator = "last"

      conditional_format {
        palette    = "white_on_green"
        comparator = ">="
        value      = "1"
      }

      conditional_format {
        palette    = "white_on_red"
        comparator = "<="
        value      = "0"
      }
    }
  }

  graph {
    title     = "Nodes count"
    viz       = "timeseries"
    autoscale = "true"

    request {
      q          = "sum:aws.es.nodes{$domain} by {domainname}"
      aggregator = "avg"
      type       = "line"
    }

    marker {
      type  = "warning dashed"
      value = "y = 3"
    }
  }

  graph {
    title     = "Memory pressure"
    viz       = "timeseries"
    autoscale = "true"

    request {
      q          = "max:aws.es.jvmmemory_pressure{$domain} by {domainname}"
      aggregator = "avg"
      type       = "line"
    }

    marker {
      type  = "warning dashed"
      value = "y = 75"
      label = "Triggering GC"
    }

    marker {
      type  = "error dashed"
      value = "y = 85"
      label = "Excessive GC"
    }
  }

  graph {
    title     = "Searchable documents"
    viz       = "timeseries"
    autoscale = "true"

    request {
      q          = "avg:aws.es.searchable_documents{$domain}"
      aggregator = "avg"
      type       = "line"

      style = {
        palette = "dog_classic"
        type    = "solid"
        width   = "normal"
      }
    }
  }

  graph {
    title     = "Deleted documents"
    viz       = "timeseries"
    autoscale = "true"

    request {
      q          = "avg:aws.es.deleted_documents{$domain}"
      aggregator = "avg"
      type       = "line"

      style = {
        palette = "warm"
        type    = "solid"
        width   = "normal"
      }
    }
  }

  graph {
    title     = "Ingestion rate (bytes/s)"
    viz       = "timeseries"
    autoscale = "true"

    request {
      q          = "avg:aws.es.write_throughput{$domain} by {domainname}"
      aggregator = "avg"
      type       = "line"
    }

    request {
      q          = "avg:aws.es.write_iops{$domain} by {domainname}"
      aggregator = "avg"
      type       = "line"
    }
  }

  graph {
    title     = "Search rate (bytes/s)"
    viz       = "timeseries"
    autoscale = "true"

    request {
      q          = "avg:aws.es.read_throughput{$domain} by {domainname}"
      aggregator = "avg"
      type       = "line"
    }

    request {
      q          = "avg:aws.es.read_iops{$domain} by {domainname}"
      aggregator = "avg"
      type       = "line"
    }
  }

  graph {
    title     = "Read latency"
    viz       = "timeseries"
    autoscale = "true"

    request {
      q          = "max:aws.es.read_latency{$domain}"
      aggregator = "avg"
      type       = "line"
    }

    request {
      q    = "avg:aws.es.read_latency{$domain}"
      type = "area"
    }
  }

  graph {
    title     = "Write latency"
    viz       = "timeseries"
    autoscale = "true"

    request {
      q          = "max:aws.es.write_latency{$domain}"
      aggregator = "avg"
      type       = "line"
    }

    request {
      q    = "avg:aws.es.write_latency{$domain}"
      type = "area"
    }
  }

  graph {
    title     = "CPU utilization"
    viz       = "timeseries"
    autoscale = "true"

    request {
      q          = "max:aws.es.cpuutilization{$domain}"
      aggregator = "avg"
      type       = "line"
    }

    request {
      q    = "avg:aws.es.cpuutilization{$domain}"
      type = "area"

      style = {
        palette = "orange"
        type    = "area"
      }
    }
  }

  graph {
    title     = "Blocked writes"
    viz       = "timeseries"
    autoscale = "true"

    request {
      q          = "max:aws.es.cluster_index_writes_blocked{$domain}"
      aggregator = "max"
      type       = "line"

      style = {
        palette = "orange"
        type    = "area"
      }
    }
  }

  graph {
    title       = "Consistency check execution time"
    viz         = "query_value"
    autoscale   = "true"
    custom_unit = "min"
    precision   = "0"

    request {
      q          = "max:fenway.production.elastic_search.consistency_check_and_fix.check.max{*} / 1000 / 60"
      aggregator = "last"
    }
  }

  graph {
    title     = "Consistency check counts"
    viz       = "timeseries"
    autoscale = "true"

    request {
      q          = "max:fenway.production.elastic_search.consistency_check_and_fix.extra_events_in_es{*}.as_count(), max:fenway.production.elastic_search.consistency_check_and_fix.missing_events_from_es{*}.as_count()"
      aggregator = "max"
      type       = "bars"
      stacked    = "true"

      style = {
        palette = "purple"
      }
    }
  }
}
