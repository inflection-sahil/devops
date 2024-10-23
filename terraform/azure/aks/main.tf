module "resource-group" {
  # source = "github.com/sahilphule/templates/terraform/modules/azure/resource-group"
  source = "../../../../../../templates/terraform/modules/azure/resource-group"

  resource-group-properties = local.resource-group-properties
}

module "virtual-network" {
  source = "../../../../../../templates/terraform/modules/azure/virtual-network"

  virtual-network-properties = local.virtual-network-properties
  resource-group-properties  = local.resource-group-properties
}

module "mssql" {
  source = "../../../../../../templates/terraform/modules/azure/mssql"

  mssql-properties          = local.mssql-properties
  resource-group-properties = local.resource-group-properties
  vnet-db-subnet-id         = local.vnet-db-subnet-id

  depends_on = [
    module.virtual-network
  ]
}

module "aks" {
  # source = "github.com/sahilphule/templates/terraform/modules/azure/aks"
  source = "../../../../../../templates/terraform/modules/azure/aks"

  aks-properties            = local.aks-properties
  resource-group-properties = local.resource-group-properties
  vnet-public-subnet-id     = local.vnet-public-subnet-id

  depends_on = [
    module.resource-group
  ]
}