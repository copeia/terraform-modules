# Basic project vars
variable "name" {
    description = "The name for this Hetzner module"
    type        = string
    default     = "andromeda"
}

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
        datacenter  = string
        keep_disk   = bool
        labels      = map(any)
        backups     = bool
    }))
    default     = {}
}

# Networking Vars
variable "project_network" {
    description = "Network for these Hcloud Project Servers"
    type        = any
    default     = {
        name         = "Andromeda"
        ip_range     = "10.10.10.0/16"
    }
}

variable "subnet_ip_range" {
    description = "IP address range within the project network"
    type        = string
    default     = "10.10.10.0/27"
}

# Load Balancer 
variable "lb_ip" {
    description = "Ip for network lb"
    type        = string
    default     = "10.10.10.1"
}