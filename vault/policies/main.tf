# Create policies 
resource "vault_policy" "ns_policies" {
  provider   = vault.new_namespace
  for_each   = var.policies
  name       = each.key
  policy     = each.value
  depends_on = [vault_namespace.my_namespace]
}