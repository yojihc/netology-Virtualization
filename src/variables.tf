 variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "vpc_name" {
  type    = string
  default = "develop"
}

variable "default_zone" {
  type    = string
  default = "ru-central1-a"
}

variable "default_cidr" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}

# variable "vms_ssh_root_key" {
#   type    = string
#   default = "~/.ssh/ssh-key-1760355371117.pub"
# }

variable "vm_web_family" {
  type    = string
  default = "ubuntu-2004-lts"
}

variable "vm_web_preemptible" {
  type    = bool
  default = true
}

variable "vm_web_nat" {
  type    = bool
  default = true
}

# variable "vm_web_serial_port_enable" {
#   type    = bool
#   default = true
# }

variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
    platform_id   = string
    zone          = string
  }))
  description = "Ресурсы для виртуальных машин"
}

variable "metadata" {
  type = map(string)
  description = "Метаданные для виртуальных машин"
}