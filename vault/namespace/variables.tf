variable "parent_namespace" {
  description = "The Vault namespace path to be created"
  type        = string
  default     = ""
}

variable "namespace_name" {
  description = "The Vault namespace name to be created"
  type        = string
}