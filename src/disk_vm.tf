
resource "yandex_compute_disk" "additional" {
  count = 3 
  
  name     = "disk-${count.index + 1}" 
  type     = "network-hdd"
  zone     = var.default_zone
  size     = 1  
  
   labels = {
    env  = var.environment
    type = "additional-storage"
    disk_number = tostring(count.index + 1)
  }
  
    description = "Additional disk ${count.index + 1} for storage VM"
}

locals {
    additional_disks_map = {
    for idx, disk in yandex_compute_disk.additional :
    disk.name => {
      disk_id = disk.id
      name    = disk.name
      size    = disk.size
    }
  }
}

resource "yandex_compute_instance" "storage" {
  name        = "storage"
  description = "Storage VM with additional disks attached"
  platform_id = "standard-v3"
  zone        = var.default_zone
  
    resources {
    cores  = 2
    memory = 4
  }
  
   boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id  
      size     = 10
      type     = "network-hdd"
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
  
    dynamic "secondary_disk" {
    for_each = local.additional_disks_map
    
    content {
      disk_id = secondary_disk.value.disk_id
          }
  }
  
   labels = {
    role = "storage"
    env  = var.environment
    disks_attached = tostring(length(yandex_compute_disk.additional))
  }
  
    depends_on = [yandex_compute_disk.additional]
}

output "additional_disks" {
  description = "Information about additional disks"
  value = {
    for disk in yandex_compute_disk.additional :
    disk.name => {
      id   = disk.id
      size = disk.size
      type = disk.type
      zone = disk.zone
    }
  }
}

output "storage_vm" {
  description = "Storage VM information"
  value = {
    id          = yandex_compute_instance.storage.id
    name        = yandex_compute_instance.storage.name
    public_ip   = yandex_compute_instance.storage.network_interface.0.nat_ip_address
    internal_ip = yandex_compute_instance.storage.network_interface.0.ip_address
    disks_count = length(yandex_compute_disk.additional)
  }
}

output "attached_disks_to_storage" {
  description = "Disks attached to storage VM"
  value = {
    for idx, disk in yandex_compute_disk.additional :
    "attached_disk_${idx + 1}" => {
      disk_name    = disk.name
      disk_id      = disk.id
      attached_to  = yandex_compute_instance.storage.name
      device       = "Attached via secondary_disk"
    }
  }
}

output "total_disks_created" {
  description = "Total number of additional disks created"
  value       = length(yandex_compute_disk.additional)
}