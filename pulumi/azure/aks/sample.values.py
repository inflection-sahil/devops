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
    "mysql-flexible-server-version": "8.0.21",
    "mysql-flexible-server-admin-username": "",
    "mysql-flexible-server-admin-password": "",
    "mysql-flexible-server-sku-name": "Standard_B1ms"
}

aks_properties = {
    "aks-cluster-name": "aks-cluster",
    "aks-kubernetes-version": "1.30.1",
    "aks-agent-pool-profiles-name": "nodepool",
    "aks-agent-pool-profile-type": "VirtualMachineScaleSets",
    "aks-agent-pool-profile-mode": "System",
    "aks-agent-pool-profile-vm-size": "Standard_DS2_v2",
    "aks-agent-pool-profile-max-pods": 110,
    "aks-agent-pool-profile-count": 1,
    "aks-agnet-pool-profile-enable-node-public-ip": False,
}