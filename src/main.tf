resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "develop" {
  name           = "${var.vpc_name}-web"
  zone           = var.vms_resources["web"].zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_family
}

resource "yandex_compute_instance" "platform" {
  name        = local.vm_web_name
  platform_id = var.vms_resources["web"].platform_id
  zone        = var.vms_resources["web"].zone
  
  resources {
    cores         = var.vms_resources["web"].cores
    memory        = var.vms_resources["web"].memory
    core_fraction = var.vms_resources["web"].core_fraction
  }
  
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  
  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }
  
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_nat
  }

  # metadata = {
  #   serial_port_enable = var.vm_web_serial_port_enable
  #   ssh-keys           = "ubuntu:${file(var.vms_ssh_root_key)}"
  # }
}

### DB

resource "yandex_vpc_subnet" "develop_db" {
  name           = "${var.vpc_name}-db"
  zone           = var.vms_resources["db"].zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.db_cidr 
}

resource "yandex_compute_instance" "db" {
  name        = local.vm_db_name
  platform_id = var.vms_resources["db"].platform_id
  zone        = var.vms_resources["db"].zone
  
  resources {
    cores         = var.vms_resources["db"].cores
    memory        = var.vms_resources["db"].memory
    core_fraction = var.vms_resources["db"].core_fraction
  }
  
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  
  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }
  
  network_interface {
    subnet_id = yandex_vpc_subnet.develop_db.id
    nat       = var.vm_db_nat
  }

  metadata = {
    serial_port_enable = var.metadata["serial-port-enable"]
    ssh-keys           = var.metadata["ssh-keys"]
  }
}