resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "develop" {
  name           = var.subnet_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.10.0.0/24"]
}

data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"  
  }

# Локальные переменные
locals {
    is_development = var.environment == "development"
  
    public_ssh_key = file("~/.ssh/id_rsa.pub")
}

output "network_info" {
  description = "VPC network information"
  value = {
    network_id   = yandex_vpc_network.develop.id
    network_name = yandex_vpc_network.develop.name
    subnet_id    = yandex_vpc_subnet.develop.id
    subnet_cidr  = yandex_vpc_subnet.develop.v4_cidr_blocks
  }
}

output "image_info" {
  description = "Ubuntu image information"
  value = {
    image_id   = data.yandex_compute_image.ubuntu.id
    image_name = data.yandex_compute_image.ubuntu.name
    family     = data.yandex_compute_image.ubuntu.family
  }
}