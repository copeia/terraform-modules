# Create a new ssh key for sevrer access - This requires the `TLS` provider
# https://www.terraform.io/docs/providers/aws/r/key_pair.html
resource "tls_private_key" "ssh_key" {
  algorithm     = "RSA"
  rsa_bits      = 4096
}

# Create local copy of the public ssh key for later use. Make sure to add this to your .gitignore - This requires the `local` provider
# https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file
resource "local_file" "file" {
    content           = tls_private_key.ssh_key.private_key_pem
    filename          = "${path.module}/${var.project_name}.pem"
    file_permission   = "0600"
}

# https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs
# Import new SSH key
resource "hcloud_ssh_key" "rsa_key" {
  name = "${var.project_name}.${var.servers.[0]}"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

# Create a new server 
resource "hcloud_server" "server" {
  for_each      = var.servers
  name          = each.value.name
  image         = each.value.image
  server_type   = each.value.server_type
  datacenter    = each.value.datacenter
  ssh_keys      = ["${hcloud_ssh_key.rsa_key.name}"]
  keep_disk     = each.value.keep_disk
  labels        = each.value.labels
  backups       = each.value.backups
}



## Available Datacenters

# {
#   "id": 2,
#   "name": "nbg1-dc3",
#   "description": "Nuremberg 1 DC 3"
# },
# {
#     "id": 3,
#     "name": "hel1-dc2",
#     "description": "Helsinki 1 DC 2",
# },
# {
#     "id": 4,
#     "name": "fsn1-dc14",
#     "description": "Falkenstein 1 DC14"
# }
#

## Basic Server Types - For a more extensive list checkout: curl -H "Authorization: Bearer $API_TOKEN" 'https://api.hetzner.cloud/v1/server_types'

# {
#   "id": 1,
#   "name": "cx11",
#   "description": "CX11",
#   "cores": 1,
#   "memory": 2.0,
#   "disk": 20,
# },
# {
#   "id": 3,
#   "name": "cx21",
#   "description": "CX21",
#   "cores": 2,
#   "memory": 4.0,
#   "disk": 40,
# },
# {
#   "id": 5,
#   "name": "cx31",
#   "description": "CX31",
#   "cores": 2,
#   "memory": 8.0,
#   "disk": 80,
# },
# {
#       "id": 7,
#       "name": "cx41",
#       "description": "CX41",
#       "cores": 4,
#       "memory": 16.0,
#       "disk": 160,
# },
# {
#       "id": 9,
#       "name": "cx51",
#       "description": "CX51",
#       "cores": 8,
#       "memory": 32.0,
#       "disk": 240,
# }




