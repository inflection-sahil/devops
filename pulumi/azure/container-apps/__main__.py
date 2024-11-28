from commons import resource_group, vnet, acr, mysql_flexible, container_app
import values

RESOURCE_GROUP = resource_group(values)
VNET = vnet(values, RESOURCE_GROUP)
ACR = acr(values, RESOURCE_GROUP)
MYSQL_FLEXIBLE = mysql_flexible(values, RESOURCE_GROUP, VNET)
CONTAINER_APP = container_app(values, RESOURCE_GROUP, VNET, ACR)