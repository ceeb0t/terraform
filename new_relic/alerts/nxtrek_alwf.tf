resource "newrelic_notification_destination" "destination" {
  account_id = var.newrelic_account_id
  name = "Chris Beddoe"
  type = "EMAIL"

  property {
    key = "email"
    value = "nxtrek@gmail.com"
  }
}

resource "newrelic_notification_channel" "nxtrek_alert_channel" {
  account_id = var.newrelic_account_id
  name = "Email"
  type = "EMAIL"
  destination_id = "50238ea8-5b2a-48a5-985b-d7b08b7282f2"
  product = "IINT"

  property {
    key = "subject"
    value = "{{ issueTitle }}"
  }
}

resource "newrelic_workflow" "default_alerting_workflow" {
  account_id = var.newrelic_account_id
  name = "Nxtrek Alerting Worflow"
  enabled = true
  muting_rules_handling = "DONT_NOTIFY_FULLY_MUTED_ISSUES"

  issues_filter {
    name = "workflow_filter"
    type = "FILTER"

    predicate {
      attribute = "labels.policyIds"
      operator = "EXACTLY_MATCHES"
      values = [newrelic_alert_policy.server_policy.id]
    }
  }

  destination {
    channel_id = newrelic_notification_channel.nxtrek_alert_channel.id
    notification_triggers = ["ACKNOWLEDGED", "ACTIVATED", "CLOSED", "INVESTIGATING"]
    update_original_message = true
  }
}