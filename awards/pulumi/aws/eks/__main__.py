from commons.vpc import vpc
from commons.rds import rds
from commons.eks import eks
import values

VPC = vpc(values)
RDS = rds(values, VPC)
EKS = eks(values, VPC)