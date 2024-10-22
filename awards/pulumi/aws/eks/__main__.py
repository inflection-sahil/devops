from commons import vpc, rds, eks
import values

VPC = vpc(values)
RDS = rds(values, VPC)
EKS = eks(values, VPC)