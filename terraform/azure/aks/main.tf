module "resource-group" {
  # source = "github.com/sahilphule/templates/tree/master/terraform/modules/azure/resource-group"
  source = "../../../../../templates/terraform/modules/azure/resource-group"

  resource-group-properties = local.resource-group-properties
}

module "virtual-network" {
  # source = "github.com/sahilphule/templates/tree/master/terraform/modules/azure/virtual-network"
  source = "../../../../../templates/terraform/modules/azure/virtual-network"

  virtual-network-properties = local.virtual-network-properties
  resource-group-properties  = local.resource-group-properties

  depends_on = [
    module.resource-group
  ]
}

module "acr" {
  # source = "github.com/sahilphule/templates/tree/master/terraform/modules/azure/acr"
  source = "../../../../../templates/terraform/modules/azure/acr"

  acr-properties            = local.acr-properties
  resource-group-properties = local.resource-group-properties

  depends_on = [
    module.resource-group
  ]
}

module "mysql-flexible" {
  # source = "github.com/sahilphule/templates/tree/master/terraform/modules/azure/mysql-flexible"
  source = "../../../../../templates/terraform/modules/azure/mysql-flexible"

  mysql-flexible-properties = local.mysql-flexible-properties
  resource-group-properties = local.resource-group-properties
  vnet-id                   = local.vnet-id
  vnet-name                 = local.vnet-name

  depends_on = [
    module.virtual-network
  ]
}

module "aks" {
  # source = "github.com/sahilphule/templates/tree/master/terraform/modules/azure/aks"
  source = "../../../../../templates/terraform/modules/azure/aks"

  aks-properties            = local.aks-properties
  resource-group-properties = local.resource-group-properties
  vnet-public-subnet-id     = local.vnet-public-subnet-id
  # acr-id                    = local.acr-id

  depends_on = [
    module.virtual-network
  ]
}