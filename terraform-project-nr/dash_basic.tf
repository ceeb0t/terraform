resource "newrelic_one_dashboard_json" "basic_dashboards" {
     json = file("${path.module}/dashboards/dashboard.json")
}

resource "newrelic_entity_tags" "basic_dashboards" {
	guid = newrelic_one_dashboard_json.basic_dashboards.guid
	tag {
    	     key    = "terraform"
    	     values = [true]
	}
}

output "basic_dashboards" {
      value = newrelic_one_dashboard_json.basic_dashboards.permalink
}