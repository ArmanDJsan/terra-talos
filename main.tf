module "kubernetes" {
  source  = "hcloud-k8s/kubernetes/hcloud"
  version = "3.16.0"

  hcloud_token = var.hcloud_token
  cluster_name = var.cluster_name
  
  # Probemos con los nombres base sin prefijos
  location = var.location 
  image    = var.talos_image_id

  hcloud_ccm_load_balancers_location = var.location

  talos_version      = "v1.9.5"
  kubernetes_version = "1.31.1"

  network_ipv4_cidr = "10.0.0.0/16"

  # En versiones anteriores esto se llamaba así o no existía
  # Si vuelve a fallar aquí, comentaremos esta línea
  api_allowed_networks = ["0.0.0.0/0"] 

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

  cluster_kubeconfig_path  = "kubeconfig"
  cluster_talosconfig_path = "talosconfig"
}