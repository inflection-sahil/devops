module "vpc" {
  source = "github.com/sahilphule/templates/terraform/modules/aws/vpc"

  vpc-properties = local.vpc-properties
}

module "s3" {
  source = "github.com/sahilphule/templates/terraform/modules/aws/s3"

  s3-properties = local.s3-properties
}

resource "aws_s3_object" "env-file" {
  bucket = local.s3-bucket-id
  key    = "awards/env.config"
  source = "../../../compose/.env"
  etag   = filemd5("../../../compose/.env")
}

module "rds" {
  source = "github.com/sahilphule/templates/terraform/modules/aws/rds"

  vpc-id              = local.vpc-id
  vpc-public-subnets  = local.vpc-public-subnets
  vpc-private-subnets = local.vpc-private-subnets
  database-properties = local.database-properties
  bastion-properties  = local.bastion-properties

  depends_on = [
    module.vpc
  ]
}

// module "ecr-repository" {
//  source        = "github.com/sahilphule/templates/terraform/modules/aws/ecr"
//  ecr-repository-name = local.ecr-repository-name
// }

module "load-balancer" {
  source = "github.com/sahilphule/templates/terraform/modules/aws/load-balancer"

  vpc-id                   = local.vpc-id
  vpc-public-subnets       = local.vpc-public-subnets
  load-balancer-properties = local.load-balancer-properties
}

module "ecs" {
  source = "github.com/sahilphule/templates/terraform/modules/aws/ecs"

  vpc-id              = local.vpc-id
  vpc-public-subnets  = local.vpc-public-subnets

  ecs-properties           = local.ecs-properties
  ecs-container-definition = local.ecs-container-definition
  target-group-arn         = local.load-balancer-tg-arn
  load-balancer-sg-id      = local.load-balancer-sg-id

  depends_on = [
    module.s3,
    module.rds
  ]
}