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