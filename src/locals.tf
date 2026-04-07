# locals.tf
locals {
 
  vm_web_name = "${var.vpc_name}-${var.vms_resources["web"].zone}-web"
  vm_db_name  = "${var.vpc_name}-${var.vms_resources["db"].zone}-db"
  
  vm_names = {
    web = local.vm_web_name
    db  = local.vm_db_name
  }
}