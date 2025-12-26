module "kubernetes" {
  source  = "hcloud-k8s/kubernetes/hcloud"
  version = "3.16.0"

  # 1. Pasamos el token directamente al módulo
  hcloud_token = var.hcloud_token
  cluster_name = var.cluster_name

  hcloud_ccm_load_balancers_location = var.location

  # 2. Versiones de software
  talos_version      = "v1.9.6"
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
      server_type = "cpx21",
      size        = 3,
      location    = var.location,
      type        = "cpx21"
    }
  ]

  # 5. Los Workers (CPX31)
  worker_nodepools = [
    {
      name        = "workers",
      server_type = "cpx31",
      size        = 3,
      location    = var.location,
      type        = "cpx31"
    }
  ]

  # 6. Recomendación: Rutas de archivos para no perder el acceso
  cluster_kubeconfig_path  = "kubeconfig"
  cluster_talosconfig_path = "talosconfig"
}