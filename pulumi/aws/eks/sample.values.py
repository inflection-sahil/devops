vpc_properties = {
    "vpc-name": "",
    "vpc-igw-name": "",
    "vpc-public-rt-name": "",
    "vpc-private-rt-name": "",
    "vpc-public-subnet-name": "",
    "vpc-private-subnet-name": ""
}

rds_properties = {
    "db-subnet-group-name": "",
    "db-sg-name": "",
    "db-identifier": "",
    "db-allocated-storage": 10,
    "db-engine": "",
    "db-engine-version": "",
    "db-instance-class": "",
    "db-username": "",
    "db-password": "",
    "db-publicly-accessible": False,
    "db-skip-final-snapshot": True,
}

bastion_properties = {
    "bastion-host-sg-name": "",
    "bastion-host-key-public-file": "",
    "bastion-host-instance-type": "",
    "bastion-host-name": ""    
}

eks_properties = {
    "eks-cluster-role-name": "",
    "eks-cluster-sg-name": "",
    "eks-cluster-name": "",
    "eks-node-group-role-name": "",
    "eks-node-group-name": "",
    "eks-instance-types": [""]
}