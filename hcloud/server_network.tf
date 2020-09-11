# https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs

resource "hcloud_network" "server_network" {
  for_each     = var.project_network
  name         = each.value.name
  ip_range     = each.value.ip_range
}

# Create a subnet
resource "hcloud_network_subnet" "subnet" {
  network_id   = hcloud_network.server_network.id
  type         = "cloud"
  network_zone = "eu-central"
  ip_range     = var.subnet_ip_range
}

# Add all servers to the private network
resource "hcloud_server_network" "srvnetwork" {
  for_each     = hcloud_server.server
  server_id    = each.value.id
  subnet_id    = hcloud_network_subnet.subnet.id
}
