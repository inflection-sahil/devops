locals {
  # resource group properties
  resource-group-properties = {
    rg-location = "Central India"
    rg-name     = "aca-resource-group"
  }

  # virtual network properties
  virtual-network-properties = {
    vnet-name = "aca-vnet"
    vnet-address-space = [
      "10.1.0.0/16"
    ]
    vnet-public-subnet-name = "aca-vnet-public-subnet"
    vnet-public-subnet-address-prefixes = [
      "10.1.0.0/23"
    ]
  }
  vnet-id               = module.virtual-network.vnet-id
  vnet-name             = module.virtual-network.vnet-name
  vnet-public-subnet-id = module.virtual-network.vnet-public-subnet-id

  # acr properties
  acr-properties = {
    acr-name                          = "acaacr"
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
    vnet-mysql-flexible-subnet-name = "aca-vnet-mysql-flexible-subnet"
    vnet-mysql-flexible-subnet-address-prefixes = [
      "10.1.101.0/24"
    ]

    vnet-mysql-flexible-dns-zone-name                      = "aca-vnet-mysql-flexible-dns-zone.mysql.database.azure.com"
    vnet-mysql-flexible-dns-zone-virtual-network-link-name = "aca-vnet-mysql-flexible-dns-zone-virtual-network-link.com"

    mysql-flexible-server-name            = "aca-mysql-flexible-server"
    mysql-flexible-administrator-login    = ""
    mysql-flexible-administrator-password = ""
    mysql-flexible-version                = "8.0.21"
    mysql-flexible-sku-name               = "B_Standard_B1ms"

    mysql-flexible-server-read-replica-name = "aca-mysql-flexible-server-read-replica"
  }

  # container app properties
  container-app-properties = {
    aca-acr-scope-map-pull-repo-name = "_repositories_pull"
    aca-acr-pull-token-name          = "aca-acr-pull-token"

    aca-user-assigned-identity-name = "aca-user-assigned-identity"

    aca-log-analytics-workspace-name = "aca-log-analytics-workspace"

    aca-environment-name = "aca-environment"

    aca-name = "aca"
    # aca-registry-server  = "${local.dockerhub-server}"
    aca-registry-server = "${local.acr-server}"
    container-name      = ""
    # container-image-name = "${local.dockerhub-repository-url}"
    container-image-name = "${local.acr-server}${acr-repository-url}"
  }
}