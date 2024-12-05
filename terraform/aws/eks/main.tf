module "vpc" {
  source = "github.com/sahilphule/templates/terraform/modules/aws/vpc"
  # source = "../../../../../templates/terraform/modules/aws/vpc"

  vpc-properties = local.vpc-properties
}

module "ecr-repository" {
  source = "github.com/sahilphule/templates/terraform/modules/aws/ecr"
  # source = "../../../../../templates/terraform/modules/aws/ecr"

  ecr-properties = local.ecr-properties
}

module "rds" {
  source = "github.com/sahilphule/templates/terraform/modules/aws/rds"
  # source = "../../../../../templates/terraform/modules/aws/rds"

  rds-properties          = local.rds-properties
  bastion-host-properties = local.bastion-host-properties

  vpc-id              = local.vpc-id
  vpc-public-subnets  = local.vpc-public-subnets
  vpc-private-subnets = local.vpc-private-subnets

  depends_on = [
    module.vpc
  ]
}

module "eks" {
  source = "github.com/sahilphule/templates/terraform/modules/aws/eks"
  # source = "../../../../../templates/terraform/modules/aws/eks"

  eks-properties     = local.eks-properties
  vpc-public-subnets = local.vpc-public-subnets

  depends_on = [
    module.ecr-repository,
    module.rds
  ]
}