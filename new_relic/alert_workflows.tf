resource "newrelic_alert_policy" "server_policy" {
  name                = "CPU Alert Policy"
  incident_preference  = "PER_CONDITION"  # Options: PER_POLICY, PER_CONDITION, PER_CONDITION_AND_TARGET
}