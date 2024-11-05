locals {
  # resource group properties
  resource-group-properties = {
    rg-location = "Central India"
    rg-name     = "container-apps-resource-group"
  }

  # virtual network properties
  virtual-network-properties = {
    vnet-name = "container-apps-vnet"
    vnet-address-space = [
      "10.1.0.0/16"
    ]
    vnet-public-subnet-name = "container-apps-vnet-public-subnet"
    vnet-public-subnet-address-prefixes = [
      "10.1.0.0/23"
    ]
  }
  vnet-id               = module.virtual-network.vnet-id
  vnet-name             = module.virtual-network.vnet-name
  vnet-public-subnet-id = module.virtual-network.vnet-public-subnet-id

  # acr properties
  acr-properties = {
    acr-name                          = "container-appsacr"
    acr-sku                           = "Basic"
    acr-public-network-access-enabled = true
  }
  acr-id   = module.acr.acr-id
  acr-name = module.acr.acr-name

  acr-server         = module.acr.acr-login-server
  acr-repository-url = ""

  dockerhub-server         = "docker.io"
  dockerhub-repository-url = ""

  # mysql flexible properties
  mysql-flexible-properties = {
    vnet-mysql-flexible-subnet-name = "container-apps-vnet-mysql-flexible-subnet"
    vnet-mysql-flexible-subnet-address-prefixes = [
      "10.1.101.0/24"
    ]

    vnet-mysql-flexible-dns-zone-name                      = "container-apps-vnet-mysql-flexible-dns-zone.mysql.database.azure.com"
    vnet-mysql-flexible-dns-zone-virtual-network-link-name = "container-apps-vnet-mysql-flexible-dns-zone-virtual-network-link.com"

    mysql-flexible-server-name            = "container-apps-mysql-flexible-server"
    mysql-flexible-administrator-login    = ""
    mysql-flexible-administrator-password = ""
    mysql-flexible-version                = "8.0.21"
    mysql-flexible-sku-name               = "B_Standard_B1ms"

    mysql-flexible-server-read-replica-name = "container-apps-mysql-flexible-server-read-replica"
  }

  # container app properties
  container-app-properties = {
    container-apps-acr-scope-map-pull-repo-name = "_repositories_pull"
    container-apps-acr-pull-token-name          = "container-apps-acr-pull-token"

    container-apps-user-assigned-identity-name = "container-apps-user-assigned-identity"

    container-apps-log-analytics-workspace-name = "container-apps-log-analytics-workspace"

    container-apps-environment-name = "container-apps-environment"

    container-apps-name = "container-apps"
    # container-apps-registry-server  = "${local.dockerhub-server}"
    container-apps-registry-server = "${local.acr-server}"
    container-name      = ""
    # container-image-name = "${local.dockerhub-repository-url}"
    container-image-name = "${local.acr-server}${acr-repository-url}"
  }
}