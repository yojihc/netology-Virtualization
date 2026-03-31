variable "each_vm" {
  description = "Configuration for database VMs"
  type = list(object({
    vm_name       = string
    cpu           = number
    ram           = number
    disk_volume   = number
    platform_id   = optional(string, "standard-v3")
    disk_type     = optional(string, "network-hdd")
    core_fraction = optional(number, 100)
  }))
  default = [
    {
      vm_name       = "main"
      cpu           = 2
      ram           = 1
      disk_volume   = 10
      platform_id   = "standard-v3"
      disk_type     = "network-ssd"
      core_fraction = 20
    },
    {
      vm_name       = "replica"
      cpu           = 2
      ram           = 2
      disk_volume   = 20
      platform_id   = "standard-v3"
      disk_type     = "network-hdd"
      core_fraction = 20
    }
  ]
}

locals {
  db_instances_map = { for vm in var.each_vm : vm.vm_name => vm }
}

resource "yandex_compute_instance" "database" {
  for_each = local.db_instances_map
  
  name        = "db-${each.value.vm_name}"
  platform_id = each.value.platform_id
  zone        = var.default_zone
  
  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fraction
  }
  
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id  
      size     = each.value.disk_volume
      type     = each.value.disk_type
    }
  }
  
  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat                = false
  }
  
  metadata = {
    ssh-keys = "ubuntu:${local.public_ssh_key}"
    serial-port-enable = 1
  }
  
  labels = {
    role = "database"
    type = each.value.vm_name
    env  = var.environment
  }
  
  depends_on = [yandex_compute_instance.web]
}

output "database_instances" {
  description = "Database instances information"
  value = {
    for name, vm in yandex_compute_instance.database :
    name => {
      id          = vm.id
      name        = vm.name
      internal_ip = vm.network_interface.0.ip_address
      cpu         = vm.resources[0].cores
      ram         = vm.resources[0].memory
      disk_size   = vm.boot_disk[0].initialize_params[0].size
    }
  }
}