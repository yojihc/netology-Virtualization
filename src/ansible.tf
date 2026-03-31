locals {
   web_servers = [
    for idx, vm in yandex_compute_instance.web : {
      name        = vm.name
      host        = vm.network_interface.0.nat_ip_address
      internal_ip = vm.network_interface.0.ip_address
      fqdn        = vm.fqdn  
      group       = "webservers"
    }
  ]
  
   database_servers = [
    for name, vm in yandex_compute_instance.database : {
      name        = vm.name
      host        = vm.network_interface.0.nat_ip_address != "" ? vm.network_interface.0.nat_ip_address : vm.network_interface.0.ip_address
      internal_ip = vm.network_interface.0.ip_address
      fqdn        = vm.fqdn
      group       = "databases"
    }
  ]
  
  storage_server = [
    {
      name        = yandex_compute_instance.storage.name
      host        = yandex_compute_instance.storage.network_interface.0.nat_ip_address
      internal_ip = yandex_compute_instance.storage.network_interface.0.ip_address
      fqdn        = yandex_compute_instance.storage.fqdn
      group       = "storage"
    }
  ]
  
   all_servers = concat(
    local.web_servers,
    local.database_servers,
    local.storage_server
  )
  
   server_groups = {
    webservers = local.web_servers
    databases  = local.database_servers
    storage    = local.storage_server
  }
}

resource "local_file" "ansible_inventory" {
  filename = "${path.module}/inventory.ini"
  content = templatefile("${path.module}/inventory.tpl", {
    all_servers    = local.all_servers
    server_groups  = local.server_groups
    web_servers    = local.web_servers
    database_servers = local.database_servers
    storage_server = local.storage_server
  })
  
  depends_on = [
    yandex_compute_instance.web,
    yandex_compute_instance.database,
    yandex_compute_instance.storage
  ]
}

output "ansible_inventory_content" {
  description = "Content of the generated Ansible inventory"
  value       = local_file.ansible_inventory.content
  sensitive   = false
}

output "inventory_file_path" {
  description = "Path to the generated inventory file"
  value       = local_file.ansible_inventory.filename
}

output "all_servers_list" {
  description = "List of all servers for debugging"
  value = {
    webservers = local.web_servers
    databases  = local.database_servers
    storage    = local.storage_server
  }
}