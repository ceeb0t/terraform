resource "newrelic_notification_destination" "destination" {
  account_id = 6807300
  name = "Chris Beddoe"
  type = "EMAIL"

  property {
    key = "email"
    value = "nxtrek@gmail.com"
  }
}