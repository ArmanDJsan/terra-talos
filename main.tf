module "kubernetes" {
  source  = "hcloud-k8s/kubernetes/hcloud"
  version = "1.3.0"

  cluster_name = var.cluster_name
  location     = var.location

  # Red interna de alta velocidad
  network_ipv4_cidr = "10.0.0.0/16"

  # Alta Disponibilidad: 3 Masters
  control_plane_nodepools = [
    {
      name        = "control-plane",
      server_type = "cpx21",
      size        = 3,
      location    = var.location
    }
  ]

  # Nodos de aplicaciones: 3 Workers
  worker_nodepools = [
    {
      name        = "workers",
      server_type = "cpx31",
      size        = 3,
      location    = var.location
    }
  ]

  # Add-ons listos para producción
  hcloud_csi_enabled         = true # Discos
  ingress_controller_enabled = true # Nginx
  cert_manager_enabled       = true # SSL
}
