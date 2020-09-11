# https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs
resource "hcloud_load_balancer" "load_balancer" {
  count      = "${var.enable_lb == "true" ? 1 : 0}"
  name       = "${var.project_name}"
  load_balancer_type = "lb11"
  location   = var.servers[0].location
  target {
    type = "server"
    server_id = each.hcloud_server.server.id
  }
}