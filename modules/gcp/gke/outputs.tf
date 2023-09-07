output "k8s_network" {
  value = google_container_cluster.primary.network
}

output "k8s_subnetwork" {
  value = google_container_cluster.primary.subnetwork
}

output "k8s-cluster-endpoint" {
    value = google_container_cluster.primary.endpoint
#     sensitive = true
}

output "cluster_ca_cert" {
    value = google_container_cluster.primary.master_auth[0].cluster_ca_certificate
    sensitive = true
}
output "client_certificate" {
  value     = google_container_cluster.primary.master_auth.0.client_certificate
  sensitive = true
}

output "client_key" {
  value     = google_container_cluster.primary.master_auth.0.client_key
  sensitive = true
}

output "access_token" {
    value = data.google_client_config.default.access_token
    sensitive = true
}

output "kubeconfig" {
  value = local_file.kubeconfig.filename
}
