module "kubernetes" {
  source  = "hcloud-k8s/kubernetes/hcloud"
  version = "3.16.0"

  hcloud_token = var.hcloud_token
  cluster_name = var.cluster_name

  # CAMBIO: Ahora pasamos un objeto en lugar de un string
  packer_amd64_builder = {
    image_id = var.talos_image_id
  }

  hcloud_ccm_load_balancers_location = var.location

  talos_version      = "v1.9.5"
  kubernetes_version = "1.31.1"

  network_ipv4_cidr = "10.0.0.0/16"

  # Firewall usando los nombres exactos de tu grep
  firewall_talos_api_source = ["0.0.0.0/0"]
  firewall_kube_api_source  = ["0.0.0.0/0"]

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