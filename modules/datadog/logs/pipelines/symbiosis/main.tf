resource "datadog_logs_custom_pipeline" "symbiosis" {
  filter {
    query = "\"[SymbiosisSync] Sending\""
  }

  name       = "Symbiosis Sync SQS Messages"
  is_enabled = true

  processor {
    grok_parser {
      samples = [
        "[3d8853a5133449de1b8a2d21284fc38f] [SymbiosisSync] Sending message to SQS: {\"queue_url\":\"https://sqs.eu-west-1.amazonaws.com/688013719659/tso_symbiosis.fifo\",\"message_group_id\":\"3d8853a5133449de1b8a2d21284fc38f\",\"message_deduplication_id\":\"bf7756183cc9beab0634c495bb27eab50536cf08c1d2cebe00a7eb02311b8a21\",\"message_body\":\"{\\\"app\\\":\\\"kitdashboard\\\",\\\"model_name\\\":\\\"User\\\",\\\"model_id\\\":\\\"140145\\\",\\\"action\\\":\\\"update\\\",\\\"user_id\\\":null,\\\"organisation_id\\\":6,\\\"changed_at\\\":1687943331,\\\"changeset\\\":{\\\"lastname\\\":\\\"Athlete Test\\\",\\\"updated\\\":\\\"2023-06-28T10:08:51.000+01:00\\\"}}\"}",
        "[SymbiosisSync] Sending message to SQS: {\"queue_url\":\"https://sqs.eu-west-1.amazonaws.com/688013719659/tso_symbiosis.fifo\",\"message_group_id\":\"772a7a59-0f52-3a58-adfe-88131d412667\",\"message_deduplication_id\":\"4b9c253c6b22f437f2051837f142c12d1cfb21d374031a3364fa9804b8e676b5\",\"message_body\":\"{\\\"app\\\":\\\"medinah\\\",\\\"model_name\\\":\\\"ExternalEntityMapping\\\",\\\"model_id\\\":\\\"301442\\\",\\\"action\\\":\\\"create\\\",\\\"user_id\\\":null,\\\"organisation_id\\\":1275,\\\"changed_at\\\":1690207158,\\\"changeset\\\":{\\\"id\\\":301442,\\\"entity_mapping_hash\\\":\\\"13253706869840503455\\\",\\\"external_identifier\\\":\\\"TSO§footballpma§1002176§Athlete\\\",\\\"externally_mappable_type\\\":\\\"Athlete\\\",\\\"externally_mappable_id\\\":54752,\\\"created_at\\\":\\\"2023-07-24T13:59:18.000Z\\\",\\\"updated_at\\\":\\\"2023-07-24T13:59:18.000Z\\\",\\\"organisation_id\\\":1275}}\"}",
      ]

      source = "message"

      grok {
        support_rules = ""

        match_rules = <<-EOT
        basic_sync_message \[SymbiosisSync\] Sending message to SQS: %%{data:symbiosis:json}
        rails_sync_message \[%%{notSpace:request_id}\] %%{basic_sync_message}
        EOT
      }

      name       = "Symbiosis Sync JSON Processor"
      is_enabled = true
    }
  }

  processor {
    grok_parser {
      samples = [
        "[SymbiosisSync] Sending message to SQS: {\"queue_url\":\"https://sqs.eu-west-1.amazonaws.com/688013719659/tso_symbiosis.fifo\",\"message_group_id\":\"772a7a59-0f52-3a58-adfe-88131d412667\",\"message_deduplication_id\":\"4b9c253c6b22f437f2051837f142c12d1cfb21d374031a3364fa9804b8e676b5\",\"message_body\":\"{\\\"app\\\":\\\"medinah\\\",\\\"model_name\\\":\\\"ExternalEntityMapping\\\",\\\"model_id\\\":\\\"301442\\\",\\\"action\\\":\\\"create\\\",\\\"user_id\\\":null,\\\"organisation_id\\\":1275,\\\"changed_at\\\":1690207158,\\\"changeset\\\":{\\\"id\\\":301442,\\\"entity_mapping_hash\\\":\\\"13253706869840503455\\\",\\\"external_identifier\\\":\\\"TSO§footballpma§1002176§Athlete\\\",\\\"externally_mappable_type\\\":\\\"Athlete\\\",\\\"externally_mappable_id\\\":54752,\\\"created_at\\\":\\\"2023-07-24T13:59:18.000Z\\\",\\\"updated_at\\\":\\\"2023-07-24T13:59:18.000Z\\\",\\\"organisation_id\\\":1275}}\"}",
      ]

      source = "sidekiq.message"

      grok {
        support_rules = ""

        match_rules = <<-EOT
        rule \[SymbiosisSync\] Sending message to SQS: %%{data:symbiosis:json}
        EOT
      }

      name       = "Symbiosis Sync JSON Processor for Sidekiq logs"
      is_enabled = true
    }
  }

  processor {
    grok_parser {
      samples = [
        "{\"app\":\"kitdashboard\",\"model_name\":\"Athlete\",\"model_id\":\"78041\",\"action\":\"update\",\"user_id\":null,\"organisation_id\":6,\"changed_at\":1687944301,\"changeset\":{\"lastname\":\"Athlete Test2\",\"updated\":\"2023-06-28T10:25:01.000+01:00\"}}",
      ]

      source = "symbiosis.message_body"

      grok {
        support_rules = ""

        match_rules = <<-EOT
        message_body_json %%{data:symbiosis.message_body:json}
        EOT
      }

      name       = "Symbiosis Sync Nested JSON Processor"
      is_enabled = true
    }
  }

  processor {
    lookup_processor {
      lookup_table = [
        "4,Everton",
        "12,Norwich City",
        "16,Aston Villa",
        "66,Brentford",
        "874,Chelsea",
        "991,Ipswich Town",
        "1215,Accrington Stanley",
        "1216,AFC Wimbledon",
        "1217,Barnsley",
        "1218,Barrow",
        "1219,Blackpool",
        "1220,Bolton Wanderers",
        "1221,Bradford City",
        "1222,Bristol Rovers",
        "1223,Burton Albion",
        "1224,AFC Bournemouth",
        "1225,Arsenal",
        "1226,Barnet",
        "1227,Birmingham City",
        "1228,Blackburn Rovers",
        "1229,Brighton & Hove Albion",
        "1230,Bristol City",
        "1231,Burnley",
        "1232,Bury",
        "1233,Premier League",
        "1236,Cambridge United",
        "1237,Cardiff City",
        "1238,Carlisle United",
        "1239,Charlton Athletic",
        "1240,Cheltenham Town",
        "1241,Chesterfield",
        "1242,Colchester United",
        "1243,Coventry City",
        "1244,Crawley Town",
        "1245,Crewe Alexandra",
        "1246,Crystal Palace",
        "1247,Dagenham & Redbridge",
        "1248,Derby County",
        "1249,Doncaster Rovers",
        "1250,Exeter City",
        "1251,Fleetwood Town",
        "1252,Forest Green Rovers",
        "1253,Gillingham",
        "1254,Grimsby Town",
        "1255,Harrogate Town",
        "1256,Hartlepool United",
        "1257,Huddersfield Town",
        "1258,Hull City",
        "1263,Leeds United",
        "1264,Leicester City",
        "1265,Leyton Orient",
        "1266,Lincoln City",
        "1269,Liverpool",
        "1270,Luton Town",
        "1271,Manchester City",
        "1272,Mansfield Town",
        "1273,Middlesbrough",
        "1274,Millwall",
        "1275,Milton Keynes Dons",
        "1276,Morecambe",
        "1277,Newcastle United",
        "1278,Newport County",
        "1279,Northampton Town",
        "1280,Nottingham Forest",
        "1281,Notts County",
        "1282,Oldham Athletic",
        "1283,Oxford United",
        "1284,Manchester United",
        "1285,Wrexham",
        "1286,Peterborough United",
        "1287,Plymouth Argyle",
        "1288,Port Vale",
        "1289,Portsmouth",
        "1290,Preston North End",
        "1291,Queens Park Rangers",
        "1292,Reading",
        "1293,Rochdale",
        "1294,Rotherham United",
        "1295,Salford City",
        "1296,Scunthorpe United",
        "1297,Sheffield United",
        "1298,Sheffield Wednesday",
        "1299,Shrewsbury Town",
        "1300,Southampton",
        "1301,Southend United",
        "1302,York City",
        "1303,Stevenage",
        "1304,Yeovil Town",
        "1305,Stockport County",
        "1306,Stoke City",
        "1307,Wycombe Wanderers",
        "1308,Sunderland",
        "1309,Wolverhampton Wanderers",
        "1310,Sutton United",
        "1311,Swansea City",
        "1312,Wigan Athletic",
        "1313,Swindon Town",
        "1314,West Ham United",
        "1315,West Bromwich Albion",
        "1316,Watford",
        "1317,Walsall",
        "1318,Tottenham Hotspur",
        "1319,Tranmere Rovers",
        "1320,Deleted Players",
        "1434,Fulham",
        "1472,Premier League Unassigned",
      ]

      source         = "symbiosis.message_body.organisation_id"
      target         = "symbiosis.organisation"
      default_lookup = "Unknown"
      name           = "Symbiosis Sync Organisation Name Lookup"
      is_enabled     = true
    }
  }
}
