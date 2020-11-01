// KV Secrets
resource "vault_mount" "kv" {
  for_each    = var.kv_groups
  depends_on  = [vault_namespace.my_namespace]
  provider    = vault.new_namespace
  path        = each.value.kv_path
  type        = "kv"
}