// Mount database secrets
resource "vault_mount" "database_engine" {
  for_each    = var.database_engine_mounts
  depends_on  = [vault_namespace.my_namespace]
  provider    = vault.new_namespace
  path        = each.value.mount_information.path
  type        = each.value.mount_information.type
  description = each.value.mount_information.description
}

// Configure database connection
resource "vault_database_secret_backend_connection" "database_connection" {
  for_each      = var.database_engine_connections
  depends_on    = [vault_mount.database_engine, time_sleep.delay]
  provider      = vault.new_namespace
  backend       = each.value.backend
  name          = each.value.name
  allowed_roles = each.value.allowed_roles
  mssql {
    connection_url = each.value.mssql.connection_url
  }
}

// Create database dynamic role
resource "vault_database_secret_backend_role" "database_role" {
  for_each            = var.database_backend_roles
  depends_on          = [vault_mount.database_engine, time_sleep.delay]
  provider            = vault.new_namespace
  backend             = each.value.backend
  name                = each.value.name
  db_name             = each.value.db_name
  creation_statements = each.value.creation_statements
}