variable "hcloud_token" {
  description = "API Token de Hetzner Cloud"
  type        = string
  sensitive   = true
}

variable "cluster_name" {
  default = "v1"
}

variable "location" {
  default = "nbg1" # Nuremberg
}
