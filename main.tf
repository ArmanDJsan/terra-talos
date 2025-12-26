module "kubernetes" {
  source  = "hcloud-k8s/kubernetes/hcloud"
  version = "3.16.0"

  # Credenciales y General
  hcloud_token = var.hcloud_token
  cluster_name = var.cluster_name
  
  # CAMBIO: Nombres exactos para la v3.16.x
  hcloud_location = var.location 
  talos_image_id  = var.talos_image_id

  # Configuración técnica
  hcloud_ccm_load_balancers_location = var.location
  talos_version                      = "v1.9.5"
  kubernetes_version                 = "1.31.1"

  # Red
  network_ipv4_cidr = "10.0.0.0/16"
  
  # CAMBIO: En esta versión se suele usar este nombre para los accesos
  talos_api_allowed_networks = ["0.0.0.0/0"] 

  # Nodepools
  control_plane_nodepools = [
    {
      name     = "master",
      type     = "cpx21",
      count    = 3,
      location = var.location
    }
  ]

  worker_nodepools = [
    {
      name     = "workers",
      type     = "cpx31",
      count    = 3,
      location = var.location
    }
  ]

  # Salidas
  cluster_kubeconfig_path  = "kubeconfig"
  cluster_talosconfig_path = "talosconfig"
}