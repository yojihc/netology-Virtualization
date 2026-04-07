
variable "yc_cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "yc_folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
}

variable "default_zone" {
  description = "Default availability zone"
  type        = string
  default     = "ru-central1-a"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "development"
}

variable "vpc_name" {
  description = "VPC network name"
  type        = string
  default     = "develop"
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
  default     = "develop"
}
