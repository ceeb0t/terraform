# Generate an alert condition per hostname
resource "newrelic_nrql_alert_condition" "host_alerts_high_cpu" {
  for_each = toset(var.hostnames)

  account_id            = var.newrelic_account_id
  policy_id             = var.server_alert_policy_id
  type                  = "static"
  name                  = "Host ${each.key} - CPU > 75%"
  description           = "Alert when host ${each.key} has high CPU usage"
  enabled               = true

  nrql {
    query = "SELECT average(cpuPercent) FROM SystemSample WHERE hostname = '${each.key}'"
  }
    critical {
        operator = "above"
        threshold_duration = "60"
        threshold = "75"
        threshold_occurrences = "AT_LEAST_ONCE"
    }
}

# Generate an alert condition per hostname
resource "newrelic_nrql_alert_condition" "host_alerts_low_disk_space" {
  for_each = toset(var.hostnames)

  account_id            = var.newrelic_account_id
  policy_id             = var.server_alert_policy_id
  type                  = "static"
  name                  = "Host ${each.key} - Disk Space < 20%"
  description           = "Alert when host ${each.key} has low disk space"
  enabled               = true

  nrql {
    query = "SELECT average(diskFreePercent) FROM SystemSample WHERE hostname = '${each.key}'"
  }
    critical {
        operator = "below"
        threshold_duration = "60"
        threshold = "20"
        threshold_occurrences = "AT_LEAST_ONCE"
    }
}