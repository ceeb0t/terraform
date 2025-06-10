variable "notification_channel_id" {
  description = "The ID of the New Relic notification channel for Bookstack alerts"
  type        = string
}

variable "server_alert_policy_id" {
  description = "The ID of the New Relic alert policy for server alerts"
  type        = string
}

variable "newrelic_account_id" {
  description = "New Relic account ID"
  type        = string  
}
