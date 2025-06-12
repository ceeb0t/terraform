variable "newrelic_account_id" {
  description = "New Relic account ID"
  type        = string  
}

variable "hostnames" {
  type        = list(string)
  description = "List of hostnames to monitor"
  default = [ "bookstack","gr21-unifi" ]
}