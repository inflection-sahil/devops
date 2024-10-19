module "resource-group" {
  source = "github.com/sahilphule/templates/terraform/modules/azure/resource-group"

  resource-group-properties = local.resource-group-properties
}

module "aks" {
  source = "github.com/sahilphule/templates/terraform/modules/azure/aks"

  resource-group-properties = local.resource-group-properties
  aks-properties            = local.aks-properties

  depends_on = [
    module.resource-group
  ]
}