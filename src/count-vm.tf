resource "yandex_compute_instance" "web" {
  count = 2
  
  name        = "web-${count.index + 1}"
  platform_id = "standard-v3"
  zone        = var.default_zone
  
  resources {
    cores  = 2
    memory = 2
  }
  
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id 
      size     = 10
    }
  }
  
  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat                = true
  }
  
  metadata = {
    ssh-keys = "ubuntu:${local.public_ssh_key}"
    serial-port-enable = 1
  }
  
  labels = {
    role = "web"
    env  = var.environment
    index = tostring(count.index + 1)
  }
}

output "web_instances" {
  description = "Web instances information"
  value = {
    for idx, vm in yandex_compute_instance.web :
    vm.name => {
      id          = vm.id
      public_ip   = vm.network_interface.0.nat_ip_address
      internal_ip = vm.network_interface.0.ip_address
    }
  }
}

output "web_public_ips" {
  description = "Public IP addresses of web instances"
  value = [for vm in yandex_compute_instance.web : vm.network_interface.0.nat_ip_address]
}