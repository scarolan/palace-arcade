output "id" {
  value = azurerm_app_service.main.id

  description = "The ID of the App Service."
}

output "hostname" {
  value = azurerm_app_service.main.default_site_hostname

  description = "The default hostname for the App Service."
}

output "outbound_ips" {
  value = split(",", azurerm_app_service.main.outbound_ip_addresses)

  description = "A list of outbound IP addresses for the App Service."
}

output "possible_outbound_ips" {
  value = split(",", azurerm_app_service.main.possible_outbound_ip_addresses)

  description = "A list of possible outbound IP addresses for the App Service. Superset of outbound_ips."
}

output "principal_id" {
  value       = azurerm_app_service.main.identity[0].principal_id
  description = "The principal ID for the system-assigned identity associated with the App Service."
}

