output "container-app-url" {
  description = "container app url"
  value       = module.container-app.container-app-url
}

output "DB_HOST" {
  description = "mysql db host address"
  value = module.mysql-flexible.DB_HOST
}