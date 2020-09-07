# Basic project vars
variable "project_name" {
    description = "The name for this Hetzner project"
    type        = string
    default     = "andromeda"
}

# Hcloud Project Auth
variable "hcloud_token" {
    description = "Token for this Hcloud Project"
    type        = string
}

# Server vars
variable "servers" {
    description = "Servers for this Hcloud Project"
    type        = map(object({
        name        = string
        image       = string
        server_type = string
        location    = string
        datacenter  = string
        keep_disk   = bool
        labels      = map(any)
        backups     = bool
    }))
    default     = {}
}

# Networking Vars
variable "project_network" {
    description = "Networks for these Hcloud Project Servers"
    type        = map{
        name        = string
        ip_range    = string
    }
    default     = {}
}

variable "subnet_ip_range" {
    description = "Ip address range for these Hcloud Project Servers"
    type        = string
    default     = "10.10.10.0/27"
}