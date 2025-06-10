resource "newrelic_workflow" "workflow" {
  account_id = var.newrelic_account_id
  name = "Alerting Policy"
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