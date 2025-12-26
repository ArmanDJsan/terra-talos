variable "hcloud_token" {
  description = "API Token de Hetzner Cloud"
  type        = string
  sensitive   = true
}

variable "talos_image_id" {
  description = "El ID de la imagen de Talos generada por Packer"
  type        = string
}

variable "cluster_name" {
  default = "v2"
}

variable "location" {
  default = "nbg1" # Nuremberg
}
