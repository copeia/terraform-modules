## Mount KV groups
variable "kv_groups" {
  description = "A group of kv engines that need to be created"
  type        = map(object({
    kv_path = string
  }))
  default     = {
  }
}