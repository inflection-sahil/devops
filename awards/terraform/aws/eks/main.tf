module "vpc" {
  source = "../../../../../../../../terraform/modules/aws/vpc"

  vpc-properties = local.vpc-properties
}

module "rds" {
  source = "../../../../../../../../terraform/modules/aws/rds"

  vpc-id              = local.vpc-id
  vpc-public-subnets  = local.vpc-public-subnets
  vpc-private-subnets = local.vpc-private-subnets
  database-properties = local.database-properties
  bastion-properties  = local.bastion-properties

  depends_on = [
    module.vpc
  ]
}

module "eks" {
  source = "../../../../../../../../terraform/modules/aws/eks"

  vpc-public-subnets  = local.vpc-public-subnets
  vpc-private-subnets = local.vpc-private-subnets

  eks-properties = local.eks-properties

  depends_on = [
    module.rds
  ]
}