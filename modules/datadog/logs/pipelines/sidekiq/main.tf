resource "datadog_logs_custom_pipeline" "sidekiq" {
  filter {
    query = "sourcecategory:sidekiq"
  }

  name       = "Sidekiq"
  is_enabled = true

  processor {
    grok_parser {
      samples = ["2023-08-10T14:18:40.728Z pid=1536788 tid=ou9rakeqw class=Imports::Nfl::FeedImporter WARN: Emr::DrfirstService::DrfirstError: Athlete failed to be sent to DrFirst. Please contact support if the error persists"]
      source  = "message"

      grok {
        support_rules = ""

        match_rules = <<-EOT
        rule %%{date("yyyy-MM-dd'T'HH:mm:ss.SSSZ"):sidekiq.timestamp}\s*%%{data:sidekiq.params:keyvalue("=", ":")}\s*%%{regex("(WARN|INFO|ERROR|DEBUG)"):sidekiq.status}:\s*%%{regex(".*"):sidekiq.message}
        EOT
      }

      name       = "Parse Sidekiq logs"
      is_enabled = true
    }
  }

  processor {
    status_remapper {
      sources    = ["sidekiq.status"]
      name       = "Sidekiq Status Re-mapper"
      is_enabled = true
    }
  }
}
