# Web App for Containers (Azure App Service)

Create Web App for Containers (Azure App Service).

## Example Usage

### Docker (single container)

```hcl
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "westeurope"
}

module "web_app_container" {
  source = "innovationnorway/web-app-container/azurerm"

  name = "hello-world"

  resource_group_name = azurerm_resource_group.example.name

  container_type = "docker"

  container_image = "innovationnorway/go-hello-world:latest"
}
```

### Docker Compose (multi-container)

```hcl
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "westeurope"
}

module "web_app_container" {
  source = "innovationnorway/web-app-container/azurerm"

  name = "hello-world"

  resource_group_name = azurerm_resource_group.example.name

  container_type = "compose"

  container_config = <<EOF
version: '3'
services:
  web:
    image: "innovationnorway/go-hello-world"
    ports:
     - "80:80"
  redis:
    image: "redis:alpine"
EOF
}
```

### Kubernetes (multi-container)

```hcl
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "westeurope"
}

module "web_app_container" {
  source = "innovationnorway/web-app-container/azurerm"

  name = "hello-world"

  resource_group_name = azurerm_resource_group.example.name

  container_type = "kube"

  container_config = <<EOF
apiVersion: v1
kind: Pod
metadata:
    name: hello-world
spec:
  containers:
  - name: web
    image: innovationnorway/go-hello-world
    ports:
      - containerPort: 80
  - name: redis
    image: redis:alpine
EOF
}
```

### Configuration from file (local)

```hcl
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "westeurope"
}

module "web_app_container" {
  source = "innovationnorway/web-app-container/azurerm"

  name = "hello-world"

  resource_group_name = azurerm_resource_group.example.name

  container_type = "kube"

  container_config = file("kubernetes-pod.yaml")
}
```

### Configuration from URL (remote)

```hcl
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "westeurope"
}

data "http" "container_config" {
  url = "https://raw.githubusercontent.com/innovationnorway/go-hello-world/master/docker-compose.yml"
}

module "web_app_container" {
  source = "innovationnorway/web-app-container/azurerm"

  name = "hello-world"

  resource_group_name = azurerm_resource_group.example.name

  container_type = "compose"

  container_config = data.http.container_config.body
}
```

### Set environment variables (App Settings)

```hcl
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "westeurope"
}

module "web_app_container" {
  source = "innovationnorway/web-app-container/azurerm"

  name = "hello-world"

  resource_group_name = azurerm_resource_group.example.name

  container_type = "docker"

  container_image = "innovationnorway/go-hello-world:latest"

  app_settings = {
    MESSAGE = "Hello World!"
  }
}
```

### Configure IP restrictions

```hcl
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "westeurope"
}

module "web_app_container" {
  source = "innovationnorway/web-app-container/azurerm"

  name = "hello-world"

  resource_group_name = azurerm_resource_group.example.name

  container_type = "docker"

  container_image = "innovationnorway/go-hello-world:latest"

  ip_restrictions = ["192.168.3.4/32", "192.168.2.0/24"]
}
```

## Arguments

| Name | Type | Description |
| --- | --- | --- |
| `name` | `string` | The name of the web app. |
| `resource_group_name` | `string` | The name of an existing resource group to use for the web app. |
| `container_type` | `string` | Type of container. The options are: `docker`, `compose` and `kube`. Default: `docker`. |
| `container_config` | `string` | Configuration for the container. This should be YAML. |
| `container_image` | `string` | Container image name. Example: `innovationnorway/go-hello-world:latest`. |
| `port` | `string` | The value of the expected container port number. |
| `enable_storage` | `bool` | Mount an SMB share to the `/home/` directory. Default: `false`. |
| `start_time_limit` | `string` | Configure the amount of time (in seconds) the app service will wait before it restarts the container. Default: `230`. | 
| `command` | `string` | A command to be run on the container. |
| `app_settings` | `map` | Set web app settings. These are avilable as environment variables at runtime. |
| `app_service_plan_id` | `string` | The ID of an existing app service plan to use for the web app. Either this or `sku` should be specified. |
| `sku` | `string` | The SKU of an app service plan to create for the web app. The options are: `Basic_B1`, `Basic_B2`, `Basic_B3`, `Standard_S1`, `Standard_S2`, `Standard_S3`, `PremiumV2_P1v2`, `PremiumV2_P2v2`, and `PremiumV2_P3v2`. Default: `Basic_B1`. |
| `always_on` | `bool` | Either `true` to ensure the web app gets loaded all the time, or `false` to to unload after being idle. |
| `https_only` | `bool` | Redirect all traffic made to the web app using HTTP to HTTPS. Default: `true`. |
| `ftps_state` | `string` | Set the FTPS state value the web app. The options are: `AllAllowed`, `Disabled` and `FtpsOnly`. Default: `Disabled`. |
| `ip_restrictions` | `list` | A list of IP addresses in CIDR format specifying Access Restrictions. |
| `custom_hostnames` | `list` | List of custom hostnames to use for the web app. |
| `docker_registry_username` | `string` | The container registry username. |
| `docker_registry_url` | `string` | The container registry url. Default: `https://index.docker.io` |
| `docker_registry_password` | `string` | The container registry password. |
| `tags` | `map` | A mapping of tags to assign to the web app. |
