/* Vault root provider */
provider "vault" {
  address     = var.vault_addr
  token       = var.token
  alias       = "root"
  namespace   = "root"
  version     = "~> 2.10"
  ca_cert_file = var.ca_cert_file
  
}

/* New namespace provider to create the namespace with */
provider "vault" {
  address     = var.vault_addr
  token       = var.token
  alias       = "parent_namespace"
  namespace   = var.parent_namespace
  version     = "~> 2.10"
  ca_cert_file = var.ca_cert_file
}

/* provider to create resources in */
provider "vault" {
  address     = var.vault_addr
  token       = var.token
  alias       = "new_namespace"
  namespace   = "${var.parent_namespace}/${var.namespace_name}"
  version     = "~> 2.10"
  ca_cert_file = var.ca_cert_file
}

/* The name of the namespace provided by the call to the module */
resource "vault_namespace" "my_namespace" {
  provider   = vault.parent_namespace 
  path       = var.namespace_name
  depends_on = [time_sleep.delay]
}

