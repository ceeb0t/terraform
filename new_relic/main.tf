module "alert_policies" {
  source = "./alerts"
  newrelic_account_id = var.newrelic_account_id
}

module "dashboards" {
  source = "./dashboards"
}