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
        ssh_keys    = string
        keep_disk   = string
        labels      = map(any)
        backups     = string
    }))
    default     = {
        name        = "Andromedia"
        datacenter  = "hel1-dc2"
        server_type = "cx11"
    }
}

# Networking Vars
variable "private_networks" {
    description = "Networks for these Hcloud Project Servers"
    type        = map(object({
        name        = string
        ip_range    = string
    }))
    default     = {}
}

variable "ip_range" {
    description = "Ip address range for these Hcloud Project Servers"
    type        = string
}