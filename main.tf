module "kubernetes" {
  source  = "hcloud-k8s/kubernetes/hcloud"
  version = "3.16.0"

  hcloud_token = var.hcloud_token
  cluster_name = var.cluster_name

  # USANDO LOS NOMBRES QUE VIMOS EN EL GREP:
  # 1. El módulo no pide 'location' global, lo pide por cada nodepool y para el LB
  hcloud_ccm_load_balancers_location = var.location

  # 2. Para usar tu Snapshot 344281184, el módulo usa esta variable:
  packer_amd64_builder = var.talos_image_id

  # 3. Versiones
  talos_version      = "v1.9.5"
  kubernetes_version = "1.31.1"

  # 4. Red (Basado en tu grep: network_ipv4_cidr)
  network_ipv4_cidr = "10.0.0.0/16"

  # 5. Firewall (Basado en tu grep: firewall_talos_api_source)
  firewall_talos_api_source = ["0.0.0.0/0"]
  firewall_kube_api_source  = ["0.0.0.0/0"]

  # 6. Nodepools (Aquí sí se define la location de los servidores)
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

  # 7. Archivos de salida
  cluster_kubeconfig_path  = "kubeconfig"
  cluster_talosconfig_path = "talosconfig"
}