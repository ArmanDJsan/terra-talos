module "kubernetes" {
  source  = "hcloud-k8s/kubernetes/hcloud"
  version = "3.16.0"

  # 1. Pasamos el token directamente al módulo
  hcloud_token = var.hcloud_token
  cluster_name = var.cluster_name
  location     = var.location 

  # imagen talos
  talos_image_id = var.talos_image_id

  hcloud_ccm_load_balancers_location = var.location

  # 2. Versiones de software
  talos_version      = "v1.9.5"
  kubernetes_version = "1.31.1"

  # 3. Configuración de Red
  network_ipv4_cidr = "10.0.0.0/16"

  # CLAVE 1: Permite que Terraform vea el puerto 50000 desde fuera
  talos_api_allowed_networks = ["0.0.0.0/0"] 

  # CLAVE 2: Asegura que el módulo use la arquitectura correcta para el User Data
  talos_image_architecture = "amd64"

  # 4. Los Masters (CPX21)
  control_plane_nodepools = [
    {
      name        = "master",
      type        = "cpx21",
      count        = 3,
      location    = var.location
    }
  ]

  # 5. Los Workers (CPX31)
  worker_nodepools = [
    {
      name        = "workers",
      type        = "cpx31",
      count        = 3,
      location    = var.location
    }
  ]

  # 6. Recomendación: Rutas de archivos para no perder el acceso
  cluster_kubeconfig_path  = "kubeconfig"
  cluster_talosconfig_path = "talosconfig"
}