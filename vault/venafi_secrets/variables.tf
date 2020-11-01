variable "venafi_groups" {
  description = "A group of venafi secret engines to be created. Note the plugin must be installed on the vault host."
  type = map(object({
      path        = string
      type        = string
      description = string
  }))
  default = {
  }
}

variable "venafi_role_creation" {
  description = "Role created to interact with venafi secret backend"
  type = map(object({
      path                 = string
      ignore_absent_fields = bool
      data_json            = any
  }))
  default = {
  }
}