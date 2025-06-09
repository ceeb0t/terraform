data "newrelic_entity" "host" {
  name   = "bookstack"  # Exact match to the host name in New Relic
  domain = "INFRA"
  type   = "HOST"
}

resource "newrelic_nrql_alert_condition" "high_cpu_usage" {
    policy_id = "1587634"
    name      = "High CPU Usage: Bookstack"
    type      = "static"
    enabled   = true
    nrql {
        query = "SELECT average(cpuPercent) FROM SystemSample WHERE hostname = '${data.newrelic_entity.host.name}'"
    }
    critical {
        operator = "above"
        threshold_duration = "60"
        threshold = "2"
        threshold_occurrences = "AT_LEAST_ONCE"
    }
  }

resource "newrelic_notification_channel" "email_channel_1" {
  account_id = 6807300
  name = "Email"
  type = "EMAIL"
  destination_id = "50238ea8-5b2a-48a5-985b-d7b08b7282f2"
  product = "IINT"

  property {
    key = "subject"
    value = "{{ issueTitle }}"
  }

  property {
    key = "customDetailsEmail"
    value = "CPU over 2%"
  }
}

resource "newrelic_workflow" "workflow" {
  account_id = 6807300
  name = "Bookstack: CPU Alerting Policy"
  enabled = true
  muting_rules_handling = "DONT_NOTIFY_FULLY_MUTED_ISSUES"

  issues_filter {
    name = "workflow_filter"
    type = "FILTER"

    predicate {
      attribute = "labels.policyIds"
      operator = "EXACTLY_MATCHES"
      values = ["1587634"]
    }
  }

  destination {
    channel_id = newrelic_notification_channel.email_channel_1.id
    notification_triggers = ["ACKNOWLEDGED", "ACTIVATED", "CLOSED", "INVESTIGATING"]
    update_original_message = true
  }
}


