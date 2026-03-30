# НОВАЯ map-переменная для ресурсов ВМ
vms_resources = {
  web = {
    cores         = 2
    memory        = 1
    core_fraction = 20
    platform_id   = "standard-v3"
    zone          = "ru-central1-a"
    hdd_size      = 10
    hdd_type      = "network-hdd"
  }
  db = {
    cores         = 2
    memory        = 2
    core_fraction = 20
    platform_id   = "standard-v3"
    zone          = "ru-central1-b"
    hdd_size      = 10
    hdd_type      = "network-ssd"
  }
}

# НОВАЯ map-переменная для metadata
metadata = {
  serial-port-enable = 1
  ssh-keys           = "~/.ssh/ssh-key-1760355371117.pub"
}