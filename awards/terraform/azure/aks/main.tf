module "resource-group" {
  source = "../../../../../../terraform/modules/azure/resource-group"

  resource-group-properties = local.resource-group-properties
}

module "aks" {
  source = "../../../../../../terraform/modules/azure/aks"

  resource-group-properties = local.resource-group-properties
  aks-properties            = local.aks-properties

  depends_on = [
    module.resource-group
  ]
}