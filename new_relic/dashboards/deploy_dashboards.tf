# Read all JSON files in the dashboards folder
locals {
  dashboard_files = fileset("${path.module}/", "*.json")
  dashboards = [
    for file in local.dashboard_files : {
      name     = trimsuffix(file, ".json")
      content  = file("${path.module}/${file}")
    }
  ]
}

# Create dashboards from JSON files
resource "newrelic_one_dashboard_json" "dashboards" {
  for_each = { for d in local.dashboards : d.name => d }

  json = each.value.content
}