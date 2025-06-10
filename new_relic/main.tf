module "alert_policies" {
  source = "./alert_policies"
  notification_channel_id = newrelic_notification_channel.nxtrek_alert_channel.id
  server_alert_policy_id = newrelic_alert_policy.server_policy.id
  newrelic_account_id = var.newrelic_account_id
}

module "dashboards" {
  source = "./dashboards"
}