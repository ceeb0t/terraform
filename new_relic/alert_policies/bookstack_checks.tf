
data "newrelic_entity" "host" {
  name   = "bookstack"  # Exact match to the host name in New Relic
  domain = "INFRA"
  type   = "HOST"
}

resource "newrelic_nrql_alert_condition" "high_cpu_usage" {
    policy_id = var.server_alert_policy_id
    name      = "High CPU Usage: Bookstack"
    type      = "static"
    enabled   = true
    nrql {
        query = "SELECT average(cpuPercent) FROM SystemSample WHERE hostname = '${data.newrelic_entity.host.name}'"
    }
    critical {
        operator = "above"
        threshold_duration = "60"
        threshold = "75"
        threshold_occurrences = "AT_LEAST_ONCE"
    }
  }

resource "newrelic_nrql_alert_condition" "low_disk_space" {
    policy_id = var.server_alert_policy_id
    name      = "Low Disk Space: Bookstack"
    type      = "static"
    enabled   = true
    nrql {
        query = "SELECT average(diskFreePercent) FROM SystemSample WHERE hostname = '${data.newrelic_entity.host.name}'"
    }
    critical {
        operator = "below"
        threshold_duration = "60"
        threshold = "20"
        threshold_occurrences = "AT_LEAST_ONCE"
    }
  }


