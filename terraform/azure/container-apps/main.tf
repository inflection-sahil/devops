module "resource-group" {
  source = "github.com/sahilphule/templates/terraform/modules/azure/resource-group"
  # source = "../../../../../templates/terraform/modules/azure/resource-group"

  resource-group-properties = local.resource-group-properties
}

module "virtual-network" {
  source = "github.com/sahilphule/templates/terraform/modules/azure/virtual-network"
  # source = "../../../../../templates/terraform/modules/azure/virtual-network"

  resource-group-properties  = local.resource-group-properties
  virtual-network-properties = local.virtual-network-properties

  depends_on = [
    module.resource-group
  ]
}

module "acr" {
  source = "github.com/sahilphule/templates/terraform/modules/azure/acr"
  # source = "../../../../../templates/terraform/modules/azure/acr"

  resource-group-properties = local.resource-group-properties
  acr-properties            = local.acr-properties

  depends_on = [
    module.resource-group
  ]
}

module "mysql-flexible" {
  source = "github.com/sahilphule/templates/terraform/modules/azure/mysql-flexible"
  # source = "../../../../../templates/terraform/modules/azure/mysql-flexible"

  resource-group-properties = local.resource-group-properties
  mysql-flexible-properties = local.mysql-flexible-properties
  vnet-id                   = local.vnet-id
  vnet-name                 = local.vnet-name

  depends_on = [
    module.virtual-network
  ]
}

module "storage" {
  source = "github.com/sahilphule/templates/terraform/modules/azure/storage"
  # source = "../../../../../templates/terraform/modules/azure/storage"

  resource-group-properties = local.resource-group-properties
  storage-properties        = local.storage-properties
  vnet-public-subnet-id     = local.vnet-public-subnet-id

  depends_on = [
    module.virtual-network
  ]
}

module "container-apps" {
  source = "github.com/sahilphule/templates/terraform/modules/azure/container-apps"
  # source = "../../../../../templates/terraform/modules/azure/container-apps"

  resource-group-properties = local.resource-group-properties
  container-app-properties  = local.container-app-properties
  vnet-public-subnet-id     = local.vnet-public-subnet-id
  # acr-id                    = local.acr-id
  # acr-name                  = local.acr-name
  acr-admin-username = local.acr-admin-username
  acr-admin-password = local.acr-admin-password

  depends_on = [
    module.virtual-network
  ]
}