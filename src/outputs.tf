# outputs.tf
output "vm_details" {
  description = "Детальная информация о всех созданных ВМ: имя, внешний IP и FQDN"
  value = {
    (local.vm_web_name) = {
      instance_name = yandex_compute_instance.platform.name
      external_ip   = yandex_compute_instance.platform.network_interface.0.nat_ip_address
      fqdn          = yandex_compute_instance.platform.fqdn
    }
    (local.vm_db_name) = {
      instance_name = yandex_compute_instance.db.name
      external_ip   = yandex_compute_instance.db.network_interface.0.nat_ip_address
      fqdn          = yandex_compute_instance.db.fqdn
    }
  }
}