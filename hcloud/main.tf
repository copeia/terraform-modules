# https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs
provider "hcloud" {
  source = "hashicorp/hcloud"
  token = var.hcloud_token
}

