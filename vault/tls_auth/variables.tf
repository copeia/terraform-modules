variable "cert_auth_paths" {
  description = "a group of paths that will be used to create cert auth backends."
  type = map(object({
    cert_path = string
  }))
  default = {
  }
}

# Trying to avoid a panic bug
# Settign the type to any avoids a panic bug that should be fixed in new version (13)
variable "cert_auth_groups" {
  description = "A group of cert auth groups using maps"
  type        = map(object({
    cert_path         = string
    name              = string     
    certificate       = string
    allowed_dns_sans  = list(string)
    token_ttl         = number
    token_bound_cidrs = list(string)
    token_max_ttl     = number
    token_policies    = list(string)
  }))
  default     = {
  }
}