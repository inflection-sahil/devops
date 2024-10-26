module "resource-group" {
  source = "../../../../../../templates/terraform/modules/azure/resource-group"

  resource-group-properties = local.resource-group-properties
}

module "virtual-network" {
  source = "../../../../../../templates/terraform/modules/azure/virtual-network"

  virtual-network-properties = local.virtual-network-properties
  resource-group-properties  = local.resource-group-properties

  depends_on = [
    module.resource-group
  ]
}

module "mysql-flexible" {
  source = "../../../../../../templates/terraform/modules/azure/mysql-flexible"

  mysql-properties          = local.mysql-flexible-properties
  resource-group-properties = local.resource-group-properties
  vnet-id                   = local.vnet-id
  vnet-name                 = local.vnet-name

  depends_on = [
    module.virtual-network
  ]
}

module "aks" {
  source = "../../../../../../templates/terraform/modules/azure/aks"

  aks-properties            = local.aks-properties
  resource-group-properties = local.resource-group-properties
  vnet-name                 = local.vnet-name

  depends_on = [
    module.virtual-network
  ]
}