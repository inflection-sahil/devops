output "ecr-repository-url" {
  description = "ecr repository url"
  value       = module.ecr.ecr-repository-url
}

output "DB_HOST" {
  description = "db host address"
  value       = module.rds.DB_HOST
}

output "bastion-host-ip" {
  description = "bastion host ip address"
  value       = module.rds.bastion-host-ip
}

output "load-balancer-dns" {
  description = "load balancer dns"
  value = module.load-balancer.load-balancer-dns-name
}