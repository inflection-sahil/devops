output "aca-url" {
  description = "container app url"
  value       = module.aca.aca-url
}

output "DB_HOST" {
  description = "mysql db host address"
  value       = module.mysql-flexible.DB_HOST
}