vpc_properties = {
    "vpc-name": "",
    "vpc-igw-name": "",
    "vpc-public-rt-name": "",
    "vpc-private-rt-name": "",
    "vpc-public-subnet-name": "",
    "vpc-private-subnet-name": ""
}

s3_properties = {
    "s3-bucket-name": "",
    "s3-bucket-versioning": "",
    "s3-env-file-path" : ""
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

ecs_properties = {
    "ecs-cluster-name": "",
    "ecs-task-execution-role-name": "",
    "ecs-task-family-name": "",
    "ecs-container-name": "",
    "ecs-container-image-name": "",
    "ecs-container-port": "",
    "s3-config-bucket": s3_properties["s3-bucket-name"],
    "s3-config-path": "",

    "ecs-service-name": "",
    "ecs-service-desired-count": 1
}

ecs_container_definition = [
    {
        "name": ecs_properties["ecs-container-name"],
    	"image": ecs_properties["ecs-container-image-name"],
		"essential": True,
		"portMappings": [
            {
                "containerPort": ecs_properties["ecs-container-port"],
       			"hostPort": ecs_properties["ecs-container-port"],
				"protocol": "tcp"
			}
        ],
	    "environment": [
            {
				"name": "S3_CONFIG_BUCKET",
                "value": ecs_properties["s3-config-bucket"]
			},
            {
                "name": "S3_CONFIG_PATH",
                "value": ecs_properties["s3-config-path"]
	        }
        ]
	}
]

load_balancer_properties = {
    "load-balancer-sg-name": "",
    "load-balancer-tg-name": "",
    "port": ecs_properties["ecs-container-port"]
}