// AD secrets 
resource "vault_mount" "ad_engine" {
  for_each    = var.ad_engine_groups
  depends_on  = [vault_namespace.my_namespace]
  provider    = vault.new_namespace
  path        = each.value.mount_information.path
  type        = each.value.mount_information.type
  description = each.value.mount_information.description
}

// Configure the ad engine
resource "vault_generic_endpoint" "ad_engine_configure" {
  for_each             = var.ad_engine_groups
  depends_on           = [vault_mount.ad_engine]
  provider             = vault.new_namespace
  path                 = each.value.ad_engine_configuration.path
  ignore_absent_fields = each.value.ad_engine_configuration.ignore_absent_fields
  data_json            = each.value.ad_engine_configuration.data_json
}

// Create the ad role/s
resource "vault_generic_endpoint" "ad_engine_role" {
  for_each             = var.ad_role_creation
  depends_on           = [vault_generic_endpoint.ad_engine_configure]
  provider             = vault.new_namespace
  path                 = each.value.path
  ignore_absent_fields = each.value.ignore_absent_fields
  data_json            = each.value.data_json
}

// Create Service Account Library
resource "vault_generic_endpoint" "ad_engine_library" {
  for_each             = var.ad_engine_libraries
  depends_on           = [vault_generic_endpoint.ad_engine_configure]
  provider             = vault.new_namespace
  path                 = each.value.path
  ignore_absent_fields = each.value.ignore_absent_fields
  data_json            = each.value.data_json
}