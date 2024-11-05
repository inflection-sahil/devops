output "container-apps-url" {
  description = "container app url"
  value       = module.container-apps.container-apps-url
}

output "DB_HOST" {
  description = "mysql db host address"
  value       = module.mysql-flexible.DB_HOST
}