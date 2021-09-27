# Change to your own arcade name. This becomes part of your public URL.
# Example: http://palacearcade.azurewebsites.net/
variable "prefix" {
  default = "palace-arcade"
}

# Any docker image that runs an app on port 80 will do
# Try the scarolan/pizzaplanet image for an example change.
variable "image" {
  default = "scarolan/palacearcade"
}

# Choose a location
variable "location" {
  default = "centralus"
}

variable "https_only" {
  default = "false"
}

variable "sku_size" {
  default = "S1"
}