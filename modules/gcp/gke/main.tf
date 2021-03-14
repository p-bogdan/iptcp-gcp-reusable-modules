
# locals {
#   cluster_ca_certificate = data.google_container_cluster.default.master_auth != null ? data.google_container_cluster.default.master_auth[0].cluster_ca_certificate : ""
#   private_endpoint       = try(data.google_container_cluster.default.private_cluster_config[0].private_endpoint, "")
#   default_endpoint       = data.google_container_cluster.default.endpoint != null ? data.google_container_cluster.default.endpoint : ""
#   #endpoint               = var.use_private_endpoint == true ? local.private_endpoint : local.default_endpoint
#   endpoint               = local.default_endpoint
#   host                   = local.endpoint != "" ? "https://${local.endpoint}" : ""
#   context                = data.google_container_cluster.default.name != null ? data.google_container_cluster.default.name : ""
# }

resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  # node_locations = [
  #   var.zone,
  # ]
  location = var.zone
  project    = var.project
  remove_default_node_pool = var.remove_default_node_pool
  initial_node_count       = 1
  min_master_version = var.cluster_version
  master_auth {
     username = ""
     password = ""

     client_certificate_config {
       issue_client_certificate = var.issue_client_certificate
     }
   }
  addons_config {
    horizontal_pod_autoscaling {
      disabled = true
    }
    http_load_balancing {
      disabled = true
    }
    network_policy_config {
      disabled = true
    }
  }

}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "k8s-playground1"
  project    = var.project
  location   = var.zone
  cluster    = google_container_cluster.primary.name
  node_count = var.node_count
  version    = var.cluster_version

  management {
    auto_repair  = var.auto_repair
    auto_upgrade = var.auto_upgrade
  }
  node_config {
    preemptible  = var.preemptible 
    machine_type = var.machine_type 
    disk_size_gb = var.disk_size_gb

    metadata = {
      disable-legacy-endpoints = "true"
    }
     labels = { 
        "environment" = "test"
        "team"        = "devops"
      }

    oauth_scopes = [

      "https://www.googleapis.com/auth/cloud-platform"
      #"https://www.googleapis.com/auth/compute",
      #"https://www.googleapis.com/auth/devstorage.read_only",
      #"https://www.googleapis.com/auth/logging.write",
      #"https://www.googleapis.com/auth/monitoring"
    ]
  }
}


# #Retrieve authentication token

 data "google_container_cluster" "default" {
  name     = var.cluster_name
  location = var.zone
  project  = var.project
 }
# data "google_container_cluster" "primary" {
#   name = google_container_node_pool.primary.name
# }
 data "google_client_config" "default" {}

data "template_file" "kubeconfig" {
  template = file("${path.module}/kubeconfig-template.yaml.tpl")

  vars = {
    context                = google_container_cluster.primary.name
    cluster_ca_certificate = google_container_cluster.primary.master_auth[0].cluster_ca_certificate
    endpoint               = google_container_cluster.primary.endpoint
    token                  = data.google_client_config.default.access_token
  }
}


resource "local_file" "kubeconfig" {
  content  = data.template_file.kubeconfig.rendered
  filename = "$HOME/.kube/config"
}  

# resource "kubernetes_deployment" "example" {
#   metadata {
#     name = "terraform-example"
#     labels = {
#       app = "MyExampleApp"
#     }
#   }

#   spec {
#     replicas = 3

#     selector {
#       match_labels = {
#         test = "MyExampleApp"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           test = "MyExampleApp"
#         }
#       }

#       spec {
#         container {
#           image = "nginx:1.7.8"
#           name  = "example"

#           resources {
#             limits = {
#               cpu    = "0.5"
#               memory = "512Mi"
#             }
#             requests = {
#               cpu    = "250m"
#               memory = "50Mi"
#             }
#           }

#           liveness_probe {
#             http_get {
#               path = "/nginx_status"
#               port = 80

#               http_header {
#                 name  = "X-Custom-Header"
#                 value = "Awesome"
#               }
#             }

#             initial_delay_seconds = 3
#             period_seconds        = 3
#           }
#         }
#       }
#     }
#   }
# }
# resource "kubernetes_service" "example" {
#   metadata {
#     name = "terraform-example"
#   }
#   spec {
#     selector = {
#       app = kubernetes_deployment.example.metadata.0.labels.app
#     }
#     session_affinity = "ClientIP"
#     port {
#       port        = 8080
#       target_port = 80
#     }

#     type = "LoadBalancer"
#   }
# }