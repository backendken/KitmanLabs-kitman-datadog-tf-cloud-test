# Staff User
resource "datadog_monitor" "auditable_event_user_created" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] - [medinah] - Auditable Event: Staff User Created"
  message            = <<EOM
  Staff user_id: {{ log.attributes.user }} created a new staff user in Organisation: {{ log.attributes.organisation }}

  Application: iP For ${var.offering_type}
  Event Type: Account Creation
  Event: New Staff User Created
  Notify: ${var.notify}
  EOM
  type               = "log alert"
  query              = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:medinah sourcecategory:rails_requests source:rails @controller:UsersController @action:create @status:302\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}

resource "datadog_monitor" "auditable_event_user_edited" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] - [medinah] - Auditable Event: Staff User Edited"
  message            = <<EOM
  Staff user_id: {{ log.attributes.user }} edited user_id: {{ log.attributes.params.id }} in Organisation: {{ log.attributes.organisation }}

  Application: iP For ${var.offering_type}
  Event Type: Modifiaction
  Event: User Edited
  Notify: ${var.notify}
  EOM
  type               = "log alert"
  query              = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:medinah sourcecategory:rails_requests source:rails @controller:UsersController @action:update @status:302\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}

# Athlete
resource "datadog_monitor" "auditable_event_athlete_created" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] - [medinah] - Auditable Event: Athlete Created"
  message            = <<EOM
  Staff user_id: {{ log.attributes.user }} created a new athlete in Organisation: {{ log.attributes.organisation }}

  Application: iP For ${var.offering_type}
  Event Type: Account Creation
  Event: New Athlete Created
  Notify: ${var.notify}
  EOM
  type               = "log alert"
  query              = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:medinah sourcecategory:rails_requests source:rails @controller:Settings\\:\\:AthletesController @action:create  @status:302\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}

resource "datadog_monitor" "auditable_event_athlete_edited" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] - [medinah] - Auditable Event: Athlete Edited"
  message            = <<EOM
  Staff user_id: {{ log.attributes.user }} edited athlete_id: {{ log.attributes.params.id }} in Organisation: {{ log.attributes.organisation }}

  Application: iP For ${var.offering_type}
  Event Type: Modifiaction
  Event: Athlete Edited
  Notify: ${var.notify}
  EOM
  type               = "log alert"
  query              = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:medinah sourcecategory:rails_requests source:rails @controller:Settings\\:\\:AthletesController @action:update  @status:302\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}

resource "datadog_monitor" "auditable_event_athlete_edited_user_details" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] - [medinah] - Auditable Event: Athlete Edited (User Details)"
  message            = <<EOM
  Staff user_id: {{ log.attributes.user }} edited athlete_id: {{ log.attributes.params.athlete_id }} in Organisation: {{ log.attributes.organisation }}

  Application: iP For ${var.offering_type}
  Event Type: Modifiaction
  Event: Athlete Edited User Details
  Notify: ${var.notify}
  EOM
  type               = "log alert"
  query              = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:medinah sourcecategory:rails_requests source:rails @controller:Settings\\:\\:UserDetailsController @action:update  @status:302\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}

resource "datadog_monitor" "auditable_event_athlete_reset_password_requested" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] - [medinah] - Auditable Event: Athlete Edited (Reset Password Requested)"
  message            = <<EOM
  Staff user_id: {{ log.attributes.user }} edited athlete_id: {{ log.attributes.params.athlete_id }} in Organisation: {{ log.attributes.organisation }} requesting the password rest email to be sent.

  Application: iP For ${var.offering_type}
  Event Type: Modifiaction
  Event: Athlete Edited Reset Password Requested
  Notify: ${var.notify}
  EOM
  type               = "log alert"
  query              = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:medinah sourcecategory:rails_requests source:rails @controller:Settings\\:\\:UserDetailsController @action:reset_password  @status:302\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}

resource "datadog_monitor" "auditable_event_athlete_added_insurance_policy" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] - [medinah] - Auditable Event: Athlete Edited (Insurance Policy Added)"
  message            = <<EOM
  Staff user_id: {{ log.attributes.user }} edited athlete_id: {{ log.attributes.params.athlete_id }} in Organisation: {{ log.attributes.organisation }} adding a new insurance policy.

  Application: iP For ${var.offering_type}
  Event Type: Modifiaction
  Event: Athlete Edited - New Insurance Policy Added
  Notify: ${var.notify}
  EOM
  type               = "log alert"
  query              = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:medinah sourcecategory:rails_requests source:rails @controller:Settings\\:\\:InsurancePoliciesController @action:create @method:POST @status:201\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}

resource "datadog_monitor" "auditable_event_athlete_edited_insurance_policy" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] - [medinah] - Auditable Event: Athlete Edited (Insurance Policy Edited)"
  message            = <<EOM
  Staff user_id: {{ log.attributes.user }} edited athlete_id: {{ log.attributes.params.athlete_id }} in Organisation: {{ log.attributes.organisation }} adding a new insurance policy.

  Application: iP For ${var.offering_type}
  Event Type: Modifiaction
  Event: Athlete Edited - Insurance Policy Edited
  Notify: ${var.notify}
  EOM
  type               = "log alert"
  query              = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:medinah sourcecategory:rails_requests source:rails @controller:Settings\\:\\:InsurancePoliciesController @action:update @method:PATCH @status:200\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}

# Athlete Emergency Contact
resource "datadog_monitor" "auditable_event_athlete_added_emergancy_contact" {
  name               = "[${var.environment}] - [${element(var.regions, count.index)}] - [medinah] - Auditable Event: Athlete Edited (Emergency Contact Added)"
  message            = <<EOM
  Staff user_id: {{ log.attributes.user }} edited athlete_id: {{ log.attributes.params.athlete_id }} in Organisation: {{ log.attributes.organisation }} adding a new emergancy contact.

  Application: iP For ${var.offering_type}
  Event Type: Modifiaction
  Event: Athlete - Added New Emergancy Contact
  Notify: ${var.notify}
  EOM
  type               = "log alert"
  query              = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:medinah sourcecategory:rails_requests source:rails @controller:Settings\\:\\:EmergencyContactsController @action:create @method:POST @status:201\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  enable_logs_sample = true
  tags               = var.tags
  count              = length(var.regions)
}

resource "datadog_monitor" "auditable_event_athlete_edited_emergancy_contact" {
  name    = "[${var.environment}] - [${element(var.regions, count.index)}] - [medinah] - Auditable Event: Athlete Edited (Emergency Contact Edited)"
  message = <<EOM
  Staff user_id: {{ log.attributes.user }} edited athlete_id: {{ log.attributes.params.athlete_id }} - edited emergency contact {{ log.attributes.params.id }} in Organisation: {{ log.attributes.organisation }}

  Application: iP For ${var.offering_type}
  Event Type: Modifiaction
  Event: Athlete Edited - Emergancy Contact
  Notify: ${var.notify}
  EOM
  type    = "log alert"
  query   = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:medinah sourcecategory:rails_requests source:rails @controller:Settings\\:\\:EmergencyContactsController @action:update @method:PATCH @status:200\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  tags    = var.tags
  count   = length(var.regions)
}

resource "datadog_monitor" "auditable_event_users_profile_avatar_changed" {
  name    = "[${var.environment}] - [${element(var.regions, count.index)}] - [medinah] - Auditable Event: User Changed Avatar"
  message = <<EOM
  user_id: {{ log.attributes.user }} changed their avatar image - in Organisation: {{ log.attributes.organisation }}

  Application: iP For ${var.offering_type}
  Event Type: Modifiaction
  Event: Changed Avatar
  Notify: ${var.notify}
  EOM
  type    = "log alert"
  query   = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:medinah sourcecategory:rails_requests source:rails @controller:UserProfilesAvatarController @action:update @method:PATCH @status:200\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  tags    = var.tags
  count   = length(var.regions)
}

# ################################ #
# Account Management (Lock/Unlock) #
# ################################ #

# ################# #
# Deactivate (lock) #
# ################# #

#
# Staff User
resource "datadog_monitor" "auditable_event_users_account_deactivated" {
  name    = "[${var.environment}] - [${element(var.regions, count.index)}] - [medinah] - Auditable Event: Staff Users Account Deactivated"
  message = <<EOM
  Staff user_id: {{ log.attributes.user }} deactivated username: {{ log.attributes.params.username }} - in Organisation: {{ log.attributes.organisation }}

  Application: iP For ${var.offering_type}
  Event Type: Disabling
  Event: Staff User Account
  Notify: ${var.notify}
  EOM
  type    = "log alert"
  query   = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:medinah sourcecategory:rails_requests source:rails @controller:AccountsController @action:lock @method:PATCH @status:302 @location:*/users/*\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  tags    = var.tags
  count   = length(var.regions)
}

#
# Athlete
resource "datadog_monitor" "auditable_event_athlete_account_deactivated" {
  name    = "[${var.environment}] - [${element(var.regions, count.index)}] - [medinah] - Auditable Event: Athlete Account Deactivated"
  message = <<EOM
  Staff user_id: {{ log.attributes.user }} deactivated username: {{ log.attributes.params.username }} - in Organisation: {{ log.attributes.organisation }}

  Application: iP For ${var.offering_type}
  Event Type: Disabling
  Event: Athlete Account
  Notify: ${var.notify}
  EOM
  type    = "log alert"
  query   = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:medinah sourcecategory:rails_requests source:rails @controller:AccountsController @action:lock @method:PATCH @status:302 @location:*/athletes/*\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  tags    = var.tags
  count   = length(var.regions)
}

# ################### #
# Reactivate (unlock) #
# ################### #

#
# Staff User
resource "datadog_monitor" "auditable_event_users_account_reactivated" {
  name    = "[${var.environment}] - [${element(var.regions, count.index)}] - [medinah] - Auditable Event: Staff Users Account Reactivated"
  message = <<EOM
  Staff user_id: {{ log.attributes.user }} reactivated username: {{ log.attributes.params.username }} - in Organisation: {{ log.attributes.organisation }}

  Application: iP For ${var.offering_type}
  Event Type: Enabling
  Event: Staff User Account
  Notify: ${var.notify}
  EOM
  type    = "log alert"
  query   = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:medinah sourcecategory:rails_requests source:rails @controller:AccountsController @action:unlock @method:PATCH @status:302 @location:*/users/*\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  tags    = var.tags
  count   = length(var.regions)
}

#
# Athlete
resource "datadog_monitor" "auditable_event_athlete_account_reactivated" {
  name    = "[${var.environment}] - [${element(var.regions, count.index)}] - [medinah] - Auditable Event: Athlete Account Reactivated"
  message = <<EOM
  Staff user_id: {{ log.attributes.user }} reactivated username: {{ log.attributes.params.username }} - in Organisation: {{ log.attributes.organisation }}

  Application: iP For ${var.offering_type}
  Event Type: Enabling
  Event: Athlete Account
  Notify: ${var.notify}
  EOM
  type    = "log alert"
  query   = "logs(\"environment:${var.environment} region:${element(var.regions, count.index)} service:medinah sourcecategory:rails_requests source:rails @controller:AccountsController @action:unlock @method:PATCH @status:302 @location:*/athletes/*\").index(\"*\").rollup(\"count\").by(\"@request_id\").last(\"5m\") >= 1"
  tags    = var.tags
  count   = length(var.regions)
}
