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

module "aks" {
  source = "github.com/sahilphule/templates/terraform/modules/azure/aks"
  # source = "../../../../../templates/terraform/modules/azure/aks"

  resource-group-properties = local.resource-group-properties
  aks-properties            = local.aks-properties
  vnet-public-subnet-id     = local.vnet-public-subnet-id
  # acr-id                    = local.acr-id

  depends_on = [
    module.virtual-network
  ]
}