# Pin the Azure provider version
# add a comment here
terraform {
  required_providers {
    azurerm = {
      version = "=1.44.0"
    }
  }
}

resource "azurerm_resource_group" "arcade" {
  name     = "${var.prefix}-containerapp-demo"
  location = var.location
  tags = {
    environment = "Production"
    DoNotDelete = "True"
  }
}

# Utilize the web_app_container module from the public registry.
module "web_app_container" {
  source  = "innovationnorway/web-app-container/azurerm"
  version = "2.6.0"
  name                = var.prefix
  port                = "80"
  plan  = {
      sku_size            = var.sku_size
    }
  https_only          = var.https_only
  resource_group_name = azurerm_resource_group.arcade.name
  container_type      = "docker"
  container_image     = var.image
  depends_on          = [azurerm_resource_group.arcade]
}

output "container_app_url" {
  value = "https://${module.web_app_container.hostname}"
}
