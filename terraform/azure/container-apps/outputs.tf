output "acr-login-server" {
  description = "acr login server"
  value       = module.acr.acr-login_server
}

output "acr-admin-username" {
  description = "acr admin username"
  value       = module.acr.acr-admin-username
}

output "acr-admin-password" {
  description = "acr admin password"
  value       = module.acr.acr-admin-password
}

output "DB_HOST" {
  description = "mysql db host address"
  value       = module.mysql-flexible.DB_HOST
}

output "container-apps-url" {
  description = "container app url"
  value       = module.container-apps.container-apps-url
}