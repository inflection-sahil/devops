resource_group_properties = {
    "rg-name": "resource-group",
    "rg-location": "Central India"
}

vnet_properties = {
    "vnet-name": "vnet",
    "vnet-address-prefixes": ["10.1.0.0/16"],
    "vnet-public-subnet-count": 1,
    "vnet-subnet-names": ["vnet-subnet"]
}

acr_properties = {
    "acr-registry-name": "acr",
    "acr-admin-user-enabled": True
}

mysql_flexible_properties = {
    "mysql-flexible-subnet-name": "mysql-flexible-subnet",
    "mysql-flexible-subnet-address-prefix": "10.1.101.0/24",
    "mysql-flexible-server-name": "mysql-flexible-server",
    "mysql-flexible-server-version": "8.0",
    "mysql-flexible-server-admin-username": "",
    "mysql-flexible-server-admin-password": "",
    "mysql-flexible-server-sku-name": "Standard_B1ms"
}

container_app_properties = {
    "container-app-log-analytics-workspace-name": "container-app-log-analytics-workspace",
    "container-app-environment-name": "container-app-environment",
    "container-app-name": "container-app",
    "container-app-ingress-external-enabled": True,
    "container-app-ingress-port": 80,
    "container-name": "nginx-service",
    "container-image": "nginx"
}