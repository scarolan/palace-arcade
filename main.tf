
# Change the name pizzaplanet to your own arcade name. This becomes part of your public URL.

variable "prefix" {
  default = "pizzaplanet"
}

# Any docker image that runs an app on port 80 will do
variable "image" {
  default = "scarolan/pacman"
}

# Choose a location
variable "location" {
  default = "centralus"
}

resource "azurerm_resource_group" "arcade" {
  name     = "${var.prefix}-containerapp-demo"
  location = "${var.location}"
}

module "web_app_container" {
  source              = "innovationnorway/web-app-container/azurerm"
  name                = "${var.prefix}"
  port                = "80"
  https_only          = "false"
  resource_group_name = "${azurerm_resource_group.arcade.name}"
  resource_group_name = "palace-arcade-containerapp-demo"
  container_type      = "docker"
  container_image     = "${var.image}"
}

output "container_app_url" {
  value = "https://${module.web_app_container.hostname}"
}
