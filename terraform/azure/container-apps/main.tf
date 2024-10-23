module "resource-group" {
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

module "container-app" {
  source = "../../../../../../templates/terraform/modules/azure/container-apps"

  container-app-properties  = local.container-app-properties
  resource-group-properties = local.container-app-properties
  vnet-public-subnet-id     = local.vnet-public-subnet-id
}