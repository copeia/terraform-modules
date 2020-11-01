# https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs
resource "hcloud_load_balancer" "load_balancer" {
  for_each   = var.lb_ip
  name       = "${var.project_name}"
  load_balancer_type = "lb11"
  location   = var.servers[0].location
}

resource "hcloud_load_balancer_network" "srvnetwork" {
  for_each         = hcloud_load_balancer.load_balancer
  load_balancer_id = each.value.id
  network_id       = hcloud_network.server_network.id
  subnet_id        = hcloud_network_subnet.subnet.id
  ip               = var.lb_ip
}