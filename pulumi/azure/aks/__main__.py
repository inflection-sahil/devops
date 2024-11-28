from commons import resource_group, vnet, acr, mysql_flexible, aks
import values

RESOURCE_GROUP = resource_group(values)
VNET = vnet(values, RESOURCE_GROUP)
ACR = acr(values, RESOURCE_GROUP)
MYSQL_FLEXIBLE = mysql_flexible(values, RESOURCE_GROUP, VNET)
AKS = aks(values, RESOURCE_GROUP, VNET)