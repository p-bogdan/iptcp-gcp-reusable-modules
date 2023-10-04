output "network_name" {
  value = google_compute_network.gcp-lab-network.name
}

output "subnetwork_name" {
   value = google_compute_subnetwork.gcp-lab-subnet.name
}

output "subnetwork_id" {
value = google_compute_subnetwork.gcp-lab-subnet.id
}

output "subnet_ipv4_range" {
value = google_compute_subnetwork.gcp-lab-subnet.ip_cidr_range  
}

output "network_self_link" {
value = google_compute_network.gcp-lab-network.self_link
}

