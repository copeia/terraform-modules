# https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs
provider "hcloud" {
  token   = var.hcloud_token
  version = "~> 1.20.1"
}

provider "local" {
  version = "~> 1.4"
}

provider "tls" {
  version = "~> 2.1"
}