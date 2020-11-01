# Mount auth method
resource "vault_auth_backend" "cert" {
  depends_on  = [vault_namespace.my_namespace]
  for_each     = var.cert_auth_paths
  type        = "cert"
  provider    = vault.new_namespace
  path        = each.value.cert_path
  tune {
    max_lease_ttl      = "24h"
  }
}
# Create TLS/Cert role
resource "vault_cert_auth_backend_role" "cert" {
    provider          = vault.new_namespace
    depends_on        = [vault_auth_backend.cert, time_sleep.delay]
    for_each          = var.cert_auth_groups
    backend           = each.value.cert_path
    name              = each.value.name
    certificate       = each.value.certificate
    allowed_dns_sans  = each.value.allowed_dns_sans
    token_ttl         = each.value.token_ttl
    token_bound_cidrs = each.value.token_bound_cidrs
    token_max_ttl     = each.value.token_max_ttl
    token_policies    = each.value.token_policies
}