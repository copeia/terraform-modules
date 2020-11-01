variable "ad_engine_groups" {
  description = "Informattion relating to ad configurations"
  type = map(object({
      mount_information       = object({
        path        = string
        type        = string
        description = string
      })
      ad_engine_configuration = object({
        path                 = string
        ignore_absent_fields = bool
        data_json            = any
      })
  }))
  default = {
  }
}

variable "ad_role_creation" {
  description = "variable that will be used to store the ad related roles."
  
  type = map(object({
    path                 = string
    ignore_absent_fields = bool 
    data_json            = any
  }))
  default = {
  }
}

variable "ad_engine_libraries" {
  description = "Service Account Libraries for check-in/out via AD secrets engine"
  type = map(object({
      path                 = string
      ignore_absent_fields = bool
      data_json            = any
  }))
  default = {
  }
}