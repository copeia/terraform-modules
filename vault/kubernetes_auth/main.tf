// AppRole Authentication
resource "vault_auth_backend" "approle" {
  for_each    = var.approle_mounts
  depends_on  = [vault_namespace.my_namespace]
  type        = "approle"
  provider    = vault.new_namespace
  path        = each.value.path
  description = each.value.description
}

resource "vault_approle_auth_backend_role" "approle_role" {
  for_each       = var.approle_roles
  depends_on     = [vault_auth_backend.approle, time_sleep.delay]
  provider       = vault.new_namespace
  backend        = each.value.path
  role_name      = each.value.role_name
  token_policies = each.value.token_policies
}

resource "vault_kubernetes_auth_backend_role" "kubernetes_role" {
  for_each                         = var.kubernetes_backend_roles
  depends_on                       = [vault_mount.kubernetes_backend, vault_kubernetes_auth_backend_config.kubernetes_config]
  provider                         = vault.new_namespace
  backend                          = each.value.backend
  role_name                        = each.value.role_name
  bound_service_account_names      = each.value.bound_service_account_names
  bound_service_account_namespaces = each.value.bound_service_account_namespaces
  token_ttl                        = each.value.token_ttl
  token_policies                   = each.value.token_policies
  audience                         = each.value.audience
}