locals {

  aws_region = ""

  # vpc variables
  vpc-properties = {
    availability-zones = [
      "",
      "",
      ""
    ]
    vpc-cidr-block = ""
    vpc-subnet-count = {
      "public"  = 2,
      "private" = 2
    }
    vpc-public-subnet-cidr-blocks = [
      "",
      "",
      "",
      ""
    ]
    vpc-private-subnet-cidr-blocks = [
      "",
      "",
      "",
      ""
    ]

    vpc-tag-value                = ""
    vpc-public-subnet-tag-value  = ""
    vpc-private-subnet-tag-value = ""
    vpc-igw-tag-value            = ""
  }

  vpc-id              = module.vpc.vpc-id
  vpc-private-subnets = module.vpc.vpc-private-subnets
  vpc-public-subnets  = module.vpc.vpc-public-subnets

  # s3 variables
  s3-properties = {
    s3-bucket-name          = ""
    s3-bucket-force-destroy = true
    s3-bucket-versioning    = ""
  }
  s3-bucket-id = module.s3.s3-bucket-id

  # rds variables
  database-properties = {
    db-identifier          = ""
    db-allocated-storage   = 20
    db-engine              = ""
    db-engine-version      = ""
    db-instance-class      = ""
    db-skip-final-snapshot = true
    db-publicly-accessible = false

    db-username = ""
    db-password = ""

    db-sg-tag-value = ""
  }

  bastion-properties = {
    bastion-host-instance-type = ""
    bastion-host-public-key    = ""

    bastion-host-sg-tag-value = ""
    bastion-host-tag-value    = ""
  }

  # load balancer variables
  load-balancer-properties = {
    load-balancer-name    = ""
    load-balancer-type    = ""
    load-balancer-tg-name = ""
    port                  = "${local.ecs-properties.ecs-container-port}"

    load-balancer-sg-tag-value = ""
  }

  load-balancer-tg-arn = module.load-balancer.load-balancer-tg-arn
  load-balancer-sg-id  = module.load-balancer.load-balancer-sg-id

  # ecr variables
  # ecr-repository-name = ""
  # ecr-repository-url  = module.ecr-repository.repository-url
  dockerhub-repository-url = ""

  # ecs variables
  ecs-properties = {
    ecs-cluster-name             = ""
    ecs-task-execution-role-name = ""
    ecs-task-family              = ""
    ecs-task-name                = ""
    ecs-container-image          = "${local.dockerhub-repository-url}"
    ecs-container-name           = ""
    ecs-container-port           = ""
    s3-config-bucket             = "${local.s3-properties.s3-bucket-name}"
    s3-config-path               = ""
    ecs-service-name             = ""

    ecs-service-sg-tag-value = ""
  }

  ecs-container-definition = <<DEFINITION
    [
      {
        "name": "${local.ecs-properties.ecs-container-name}",
        "image": "${local.ecs-properties.ecs-dockerhub-repository-url}",
        "cpu": 512,
        "memory": 1024,
        "essential": true,
        "portMappings": [
          {
            "containerPort": ${local.ecs-properties.ecs-container-port},
            "hostPort": ${local.ecs-properties.ecs-container-port}
          }
        ],
        "environment": [
          {
            "name": "S3_CONFIG_BUCKET",
            "value": "${local.ecs-properties.s3-config-bucket}"
          },
          {
            "name": "S3_CONFIG_PATH",
            "value": "${local.ecs-properties.s3-config-path}"
          }
        ]
      }
    ]
    DEFINITION
}