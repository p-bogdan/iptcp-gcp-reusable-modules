#Retrieve authentication token
data "google_client_config" "default" {}


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
    http_load_balancing {
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
    ]
  }
}


  