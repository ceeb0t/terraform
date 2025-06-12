
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

resource "newrelic_nrql_alert_condition" "cpu_test" {
  account_id = 6807300
  policy_id = 1588025
  type = "static"
  name = "CPU Test"
  enabled = true
  violation_time_limit_seconds = 259200

  nrql {
    query = "SELECT average(`cpuSystemPercent`) FROM SystemSample FACET entityName"
    data_account_id = 6807300
  }

  critical {
    operator = "above"
    threshold = 1
    threshold_duration = 300
    threshold_occurrences = "all"
  }
  fill_option = "none"
  aggregation_window = 60
  aggregation_method = "event_flow"
  aggregation_delay = 120
}