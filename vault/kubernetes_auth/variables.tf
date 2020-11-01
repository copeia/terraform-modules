### K8s ###
variable "kubernetes_backend_mounts" {
  description = "Kubernetes secrets engine mounts"
  type = map(object({
      path                 = string
      ignore_absent_fields = bool
      type                 = string
  }))
  default = {
  }
}

variable "kubernetes_backend_config" {
  description = "Information relating to Kubernetes configurations"
  type = map(object({
    kubernetes_host    = string
    kubernetes_ca_cert = string
    token_review_jwt   = string
    issuer             = string
  }))
  default = {
  }
}

variable "kubernetes_backend_roles" {
  description = "Information relating to Kubernetes roles"
  type = map(object({
    role_name                         = string
    bound_service_account_names       = list(string)
    bound_service_account_namespaces  = list(string)
    token_ttl                         = number 
    token_policies                    = list(string)
    audience                          = string
  }))
  default = {
  }
}