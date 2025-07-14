resource "datadog_monitor" "auditable_event_user_edited" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] - [console] - Auditable Event: Staff User Edited"
  message            = <<EOM
  Staff user with userename: {{ log.attributes.user }} edited staff user id: {{ log.attributes.params.id }}

  Application: Console (${var.offering_type})
  Event Type: Modifiaction
  Event: User Edited
  Notify: ${var.notify}
  EOM
  type               = "log alert"
  query              = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:console sourcecategory:rails_requests source:rails @controller:UsersController @action:update @status:302 @method:PATCH\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}

resource "datadog_monitor" "auditable_event_athlete_edited" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] - [console] - Auditable Event: Athlete Edited"
  message            = <<EOM
  Staff user with userename: {{ log.attributes.user }} edited athlete id: {{ log.attributes.params.id }} in organisation: {{ log.attributes.organisation }}

  Application: Console (${var.offering_type})
  Event Type: Modifiaction
  Event: Athlete Edited
  Notify: ${var.notify}
  EOM
  type               = "log alert"
  query              = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:console sourcecategory:rails_requests source:rails @controller:AthletesController @action:update @status:302 @method:PATCH\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}

resource "datadog_monitor" "auditable_event_athlete_edited_3d_secure_toggled" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] - [console] - Auditable Event: Athlete Edited - 3D Secure Toggled"
  message            = <<EOM
  Staff user with userename: {{ log.attributes.user }} toggled the 3D secure settings for athlete id: {{ log.attributes.params.id }} in organisation: {{ log.attributes.organisation }}

  Application: Console (${var.offering_type})
  Event Type: Modifiaction
  Event: Athlete Edited - 3D Secure Toggled
  Notify: ${var.notify}
  EOM
  type               = "log alert"
  query              = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:console sourcecategory:rails_requests source:rails @controller:AthletesController @action:toggle_capture_3d @status:302 @method:GET\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}


resource "datadog_monitor" "auditable_event_athlete_edited_update_annotations" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] - [console] - Auditable Event: Athlete Edited - Updated Annotations"
  message            = <<EOM
  Staff user with userename: {{ log.attributes.user }} Updated Annotation {{ log.attributes.params.id }} for athlete id: {{ log.attributes.params.athlete_id }} in organisation: {{ log.attributes.organisation }}

  Application: Console (${var.offering_type})
  Event Type: Modifiaction
  Event: Athlete Edited - Updated Annotations
  Notify: ${var.notify}
  EOM
  type               = "log alert"
  query              = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:console sourcecategory:rails_requests source:rails @controller:AnnotationsController @action:update @status:302 @method:PATCH\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}

resource "datadog_monitor" "auditable_event_athlete_edited_update_annotations_external_source_mapping_created" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] - [console] - Auditable Event: Athlete Edited - Updated Annotations - External Source Mapping Created"
  message            = <<EOM
  Staff user with userename: {{ log.attributes.user }} Updated Annotation - External Source Mapping Created {{ log.attributes.params.id }} for athlete id: {{ log.attributes.params.athlete_id }} in organisation: {{ log.attributes.organisation }}

  Application: Console (${var.offering_type})
  Event Type: Modifiaction
  Event: Athlete Edited - Updated Annotations - External Source Mapping Created
  Notify: ${var.notify}
  EOM
  type               = "log alert"
  query              = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:console sourcecategory:rails_requests source:rails @controller:ExternalEntityMappingsController @action:create @status:302 @method:POST\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}


resource "datadog_monitor" "auditable_event_athlete_edited_update_annotations_external_source_mapping_edited" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] - [console] - Auditable Event: Athlete Edited - Updated Annotations - External Source Mapping Edited"
  message            = <<EOM
  Staff user with userename: {{ log.attributes.user }} Updated Annotation - External Source Mapping Edited {{ log.attributes.params.id }} for athlete id: {{ log.attributes.params.athlete_id }} in organisation: {{ log.attributes.organisation }}

  Application: Console (${var.offering_type})
  Event Type: Modifiaction
  Event: Athlete Edited - Updated Annotations - External Source Mapping Edited
  Notify: ${var.notify}
  EOM
  type               = "log alert"
  query              = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:console sourcecategory:rails_requests source:rails @controller:ExternalEntityMappingsController @action:update @status:302 @method:PATCH\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}

resource "datadog_monitor" "auditable_event_athlete_edited_update_annotations_external_source_mapping_deleted" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] - [console] - Auditable Event: Athlete Edited - Updated Annotations - External Source Mapping Deleted"
  message            = <<EOM
  Staff user with userename: {{ log.attributes.user }} Updated Annotation - External Source Mapping Deleted {{ log.attributes.params.id }} for athlete id: {{ log.attributes.params.athlete_id }} in organisation: {{ log.attributes.organisation }}

  Application: Console (${var.offering_type})
  Event Type: Modifiaction
  Event: Athlete Edited - Updated Annotations - External Source Mapping Deleted
  Notify: ${var.notify}
  EOM
  type               = "log alert"
  query              = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:console sourcecategory:rails_requests source:rails @controller:ExternalEntityMappingsController @action:destroy @status:302 @method:DELETE\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}

resource "datadog_monitor" "auditable_event_athlete_edited_annotations_deleted" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] - [console] - Auditable Event: Athlete Edited - Annotation Deleted"
  message            = <<EOM
  Staff user with userename: {{ log.attributes.user }} Deleted Annotation {{ log.attributes.params.id }} for athlete id: {{ log.attributes.params.athlete_id }} in organisation: {{ log.attributes.organisation }}

  Application: Console (${var.offering_type})
  Event Type: Modifiaction
  Event: Athlete Edited - Annotation Deleted
  Notify: ${var.notify}
  EOM
  type               = "log alert"
  query              = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:console sourcecategory:rails_requests source:rails @controller:AnnotationsController @action:destroy @status:302 @method:DELETE\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}

resource "datadog_monitor" "auditable_event_athlete_edited_transfer" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] - [console] - Auditable Event: Athlete Edited - Transfer"
  message            = <<EOM
  Staff user with userename: {{ log.attributes.user }} Transfered athlete id: {{ log.attributes.params.athlete_id }} in organisation: {{ log.attributes.organisation }}

  Application: Console (${var.offering_type})
  Event Type: Modifiaction
  Event: Athlete Edited - Transfered
  Notify: ${var.notify}
  EOM
  type               = "log alert"
  query              = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:console sourcecategory:rails_requests source:rails @controller:AthletesController @action:transfer_athlete @status:302 @method:POST\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}

resource "datadog_monitor" "auditable_event_athlete_created_availability" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] - [console] - Auditable Event: Athlete Edited - Created Availability"
  message            = <<EOM
  Staff user with userename: {{ log.attributes.user }} Created Availability for athlete id: {{ log.attributes.params.athlete_id }} in organisation: {{ log.attributes.organisation }}

  Application: Console (${var.offering_type})
  Event Type: Modifiaction
  Event: Athlete Edited - Created Availability
  Notify: ${var.notify}
  EOM
  type               = "log alert"
  query              = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:console sourcecategory:rails_requests source:rails @controller:SelectabilitiesController @action:create @status:302 @method:POST\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}

resource "datadog_monitor" "auditable_event_athlete_availability_edited" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] - [console] - Auditable Event: Athlete Edited - Availability Edited"
  message            = <<EOM
  Staff user with userename: {{ log.attributes.user }} Changed Availability of athlete id: {{ log.attributes.params.athlete_id }} in organisation: {{ log.attributes.organisation }}

  Application: Console (${var.offering_type})
  Event Type: Modifiaction
  Event: Athlete Edited - Availability Edited
  Notify: ${var.notify}
  EOM
  type               = "log alert"
  query              = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:console sourcecategory:rails_requests source:rails @controller:SelectabilitiesController @action:update @status:302 @method:PATCH\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}

resource "datadog_monitor" "auditable_event_athlete_availability_deleted" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] - [console] - Auditable Event: Athlete Edited - Availability Deleted"
  message            = <<EOM
  Staff user with userename: {{ log.attributes.user }} Deleted Availability of athlete id: {{ log.attributes.params.athlete_id }} in organisation: {{ log.attributes.organisation }}

  Application: Console (${var.offering_type})
  Event Type: Modifiaction
  Event: Athlete Edited - Availability Deleted
  Notify: ${var.notify}
  EOM
  type               = "log alert"
  query              = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:console sourcecategory:rails_requests source:rails @controller:SelectabilitiesController @action:destroy @status:302 @method:DELETE\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}


resource "datadog_monitor" "auditable_event_athlete_injury_occurrence_event_edited" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] - [console] - Auditable Event: Athlete Edited - Injury Occurrence Event Edited"
  message            = <<EOM
  Staff user with userename: {{ log.attributes.user }} Edited Injury Occurrence Event {{ log.attributes.params.injury_occurrence_id }} for athlete id: {{ log.attributes.params.athlete_id }} in organisation: {{ log.attributes.organisation }}

  Application: Console (${var.offering_type})
  Event Type: Modifiaction
  Event: Athlete Edited - Injury Occurrence Event Edited
  Notify: ${var.notify}
  EOM
  type               = "log alert"
  query              = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:console sourcecategory:rails_requests source:rails @controller:InjuryOccurrenceEventsController @action:update @status:302 @method:PATCH\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}

resource "datadog_monitor" "auditable_event_athlete_injury_occurrence_edited" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] - [console] - Auditable Event: Athlete Edited - Injury Occurrence Edited"
  message            = <<EOM
  Staff user with userename: {{ log.attributes.user }} Edited Injury Occurrence {{ log.attributes.id }} for athlete id: {{ log.attributes.params.athlete_id }} in organisation: {{ log.attributes.organisation }}

  Application: Console (${var.offering_type})
  Event Type: Modifiaction
  Event: Athlete Edited - Injury Occurrence Edited
  Notify: ${var.notify}
  EOM
  type               = "log alert"
  query              = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:console sourcecategory:rails_requests source:rails @controller:InjuryOccurrencesController @action:update @status:302 @method:PATCH\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}

resource "datadog_monitor" "auditable_event_athlete_injury_deleted" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] - [console] - Auditable Event: Athlete Edited - Injury Deleted"
  message            = <<EOM
  Staff user with userename: {{ log.attributes.user }} Deleted Injury {{ log.attributes.id }} for athlete id: {{ log.attributes.params.athlete_id }} in organisation: {{ log.attributes.organisation }}

  Application: Console (${var.offering_type})
  Event Type: Modifiaction
  Event: Athlete Edited - Injury Deleted
  Notify: ${var.notify}
  EOM
  type               = "log alert"
  query              = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:console sourcecategory:rails_requests source:rails @controller:InjuriesController @action:destroy @status:302 @method:DELETE\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}

resource "datadog_monitor" "auditable_event_athlete_illness_occurrence_event_edited" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] - [console] - Auditable Event: Athlete Edited - Illness Occurrence Event Edited"
  message            = <<EOM
  Staff user with userename: {{ log.attributes.user }} Edited Illness Occurrence Event {{ log.attributes.params.illness_occurrence_id }} for athlete id: {{ log.attributes.params.athlete_id }} in organisation: {{ log.attributes.organisation }}

  Application: Console (${var.offering_type})
  Event Type: Modifiaction
  Event: Athlete Edited - Illness Occurrence Event Edited
  Notify: ${var.notify}
  EOM
  type               = "log alert"
  query              = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:console sourcecategory:rails_requests source:rails @controller:IllnessOccurrenceEventsController @action:update @status:302 @method:PATCH\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}

resource "datadog_monitor" "auditable_event_athlete_illness_occurrence_edited" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] - [console] - Auditable Event: Athlete Edited - Illness Occurrence Edited"
  message            = <<EOM
  Staff user with userename: {{ log.attributes.user }} Edited Illness Occurrence {{ log.attributes.id }} for athlete id: {{ log.attributes.params.athlete_id }} in organisation: {{ log.attributes.organisation }}

  Application: Console (${var.offering_type})
  Event Type: Modifiaction
  Event: Athlete Edited - Illness Occurrence Edited
  Notify: ${var.notify}
  EOM
  type               = "log alert"
  query              = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:console sourcecategory:rails_requests source:rails @controller:IllnessOccurrencesController @action:update @status:302 @method:PATCH\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}

resource "datadog_monitor" "auditable_event_athlete_illness_deleted" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] - [console] - Auditable Event: Athlete Edited - Illness Deleted"
  message            = <<EOM
  Staff user with userename: {{ log.attributes.user }} Deleted Illness {{ log.attributes.id }} for athlete id: {{ log.attributes.params.athlete_id }} in organisation: {{ log.attributes.organisation }}

  Application: Console (${var.offering_type})
  Event Type: Modifiaction
  Event: Athlete Edited - Illness Deleted
  Notify: ${var.notify}
  EOM
  type               = "log alert"
  query              = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:console sourcecategory:rails_requests source:rails @controller:IllnessesController @action:destroy @status:302 @method:DELETE\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}

resource "datadog_monitor" "auditable_event_athlete_diagnostics_edited" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] - [console] - Auditable Event: Athlete Edited - Diagnostics Edited"
  message            = <<EOM
  Staff user with userename: {{ log.attributes.user }} Edited Diagnostics {{ log.attributes.params.id }} for athlete id: {{ log.attributes.params.athlete_id }} in organisation: {{ log.attributes.organisation }}

  Application: Console (${var.offering_type})
  Event Type: Modifiaction
  Event: Athlete Edited - Diagnostics Edited
  Notify: ${var.notify}
  EOM
  type               = "log alert"
  query              = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:console sourcecategory:rails_requests source:rails @controller:DiagnosticsController @action:update @status:302 @method:PATCH\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}

resource "datadog_monitor" "auditable_event_athlete_diagnostics_deleted" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] - [console] - Auditable Event: Athlete Edited - Diagnostics Deleted"
  message            = <<EOM
  Staff user with userename: {{ log.attributes.user }} Edited Diagnostics Deleted {{ log.attributes.params.id }} for athlete id: {{ log.attributes.params.athlete_id }} in organisation: {{ log.attributes.organisation }}

  Application: Console (${var.offering_type})
  Event Type: Modifiaction
  Event: Athlete Edited - Diagnostics Deleted
  Notify: ${var.notify}
  EOM
  type               = "log alert"
  query              = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:console sourcecategory:rails_requests source:rails @controller:DiagnosticsController @action:destroy @status:302 @method:DELETE\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}

resource "datadog_monitor" "auditable_event_athlete_treatment_session_edited" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] - [console] - Auditable Event: Athlete Edited - Treatment Session Edited"
  message            = <<EOM
  Staff user with userename: {{ log.attributes.user }} Edited Treatment Session {{ log.attributes.params.id }} for athlete id: {{ log.attributes.params.athlete_id }} in organisation: {{ log.attributes.organisation }}

  Application: Console (${var.offering_type})
  Event Type: Modifiaction
  Event: Athlete Edited - Treatment Session Edited
  Notify: ${var.notify}
  EOM
  type               = "log alert"
  query              = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:console sourcecategory:rails_requests source:rails @controller:TreatmentSessionsController @action:update @status:302 @method:PATCH\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}

resource "datadog_monitor" "auditable_event_athlete_treatment_session_deleted" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] - [console] - Auditable Event: Athlete Edited - Treatment Session Deleted"
  message            = <<EOM
  Staff user with userename: {{ log.attributes.user }} Deleted Treatment Session {{ log.attributes.params.id }} for athlete id: {{ log.attributes.params.athlete_id }} in organisation: {{ log.attributes.organisation }}

  Application: Console (${var.offering_type})
  Event Type: Modifiaction
  Event: Athlete Edited - Treatment Session Deleted
  Notify: ${var.notify}
  EOM
  type               = "log alert"
  query              = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:console sourcecategory:rails_requests source:rails @controller:TreatmentSessionsController @action:destroy @status:302 @method:DELETE\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}

resource "datadog_monitor" "auditable_event_deactivate_staff_user" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] - [console] - Auditable Event: Staff User Deactivated"
  message            = <<EOM
  Staff user with userename: {{ log.attributes.user }} Deactivated Staff User: {{ log.attributes.params.id }} in organisation: {{ log.attributes.organisation }}

  Application: Console (${var.offering_type})
  Event Type: Modifiaction
  Event: Staff User Deactivated
  Notify: ${var.notify}
  EOM
  type               = "log alert"
  query              = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:console sourcecategory:rails_requests source:rails @controller:OrganisationUsersController @action:deactivate @status:302 @method:PATCH\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}

resource "datadog_monitor" "auditable_event_activated_staff_user" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] - [console] - Auditable Event: Staff User Activated"
  message            = <<EOM
  Staff user with userename: {{ log.attributes.user }} Activated Staff User: {{ log.attributes.params.id }} in organisation: {{ log.attributes.organisation }}

  Application: Console (${var.offering_type})
  Event Type: Modifiaction
  Event: Staff User Activated
  Notify: ${var.notify}
  EOM
  type               = "log alert"
  query              = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:console sourcecategory:rails_requests source:rails @controller:OrganisationUsersController @action:activate @status:302 @method:PATCH\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}
