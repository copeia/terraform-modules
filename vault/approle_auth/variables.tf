## Approle groups
variable "approle_mounts" {
  description = "A variable that will contain information on the approle mounts"
  type        = map(object({
    path        = string
    description = string
  }))
  default     = {
  }
}
variable "approle_roles" {
  description = "A variable that will contain information on the approle roles to be created"
  type        = map(object({
    path           = string
    role_name      = string
    token_policies = list(string)
  }))
  default     = {
  }
}