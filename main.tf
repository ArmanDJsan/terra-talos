module "kubernetes" {
  source  = "hcloud-k8s/kubernetes/hcloud"
  version = "1.3.0"

  # 1. Pasamos el token directamente al módulo
  hcloud_token = var.hcloud_token
  
  cluster_name = var.cluster_name

  # 2. Versiones de software
  talos_version      = "v1.9.6"
  kubernetes_version = "1.31.1"

  # 3. Configuración de Red
  network_ipv4_cidr = "10.0.0.0/16"

  # 4. Los Masters (CPX21)
  control_plane_nodepools = [
    {
      name        = "master",
      server_type = "cpx21",
      size        = 3,
      location    = var.location
      type        = "cloud"
    }
  ]

  # 5. Los Workers (CPX31)
  worker_nodepools = [
    {
      name        = "workers",
      server_type = "cpx31",
      size        = 3,
      location    = var.location
      type        = "cloud"
    }
  ]
}