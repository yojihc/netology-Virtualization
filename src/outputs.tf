output "web_servers_fqdn" {
  description = "FQDN of web servers"
  value = {
    for vm in yandex_compute_instance.web :
    vm.name => vm.fqdn
  }
}

output "database_servers_fqdn" {
  description = "FQDN of database servers"
  value = {
    for name, vm in yandex_compute_instance.database :
    vm.name => vm.fqdn
  }
}

output "storage_server_fqdn" {
  description = "FQDN of storage server"
  value = {
    name = yandex_compute_instance.storage.name
    fqdn = yandex_compute_instance.storage.fqdn
  }
}