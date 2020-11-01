## Venafi Secrets
// Add plugiin to vault catalog
resource "vault_generic_endpoint" "venafi_pki_backend" {
  disable_read         = false
  disable_delete       = true
  path                 = "sys/plugins/catalog/secret/venafi-pki-backend"
  ignore_absent_fields = true

  data_json = jsonencode({
    sha_256 = "b7b6c7494f8adc90c5e9f3c0c4fe274adc0776eec7828812cde702237f3feca6"
    command = "venafi-pki-backend"
  })
}

// Mount the engine
resource "vault_mount" "venafi" {
  for_each    = var.venafi_groups
  depends_on  = [vault_namespace.my_namespace]
  provider    = vault.new_namespace
  path        = each.value.path
  type        = each.value.type
  description = each.value.description
}

// Create the venafi role/s
resource "vault_generic_endpoint" "venafi_engine_role" {
  for_each             = var.venafi_role_creation
  depends_on           = [vault_mount.venafi]
  provider             = vault.new_namespace
  path                 = each.value.path
  ignore_absent_fields = each.value.ignore_absent_fields
  data_json            = each.value.data_json
}