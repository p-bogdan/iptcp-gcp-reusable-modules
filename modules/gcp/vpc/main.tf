resource "google_compute_network" "gcp-lab-network" {

  project                         = var.project
  name                            = var.network_name
  auto_create_subnetworks         = var.auto_create_subnetworks
  routing_mode                    = var.routing_mode
  delete_default_routes_on_create = var.delete_default_internet_gateway_routes
}

resource "google_compute_subnetwork" "gcp-lab-subnet" {
  name          = "gcp-lab-backend-subnet"
  ip_cidr_range = var.ipv4_range_backends
  region        = var.region
  project       = var.project
  network       = google_compute_network.gcp-lab-network.self_link

}

resource "google_compute_firewall" "internal-routing" {

  name = "${var.network_name}-internal-fw-rules"
  count         = length(var.source_ranges) > 0 ? 1 : 0
  network       = google_compute_network.gcp-lab-network.self_link
  source_ranges = var.source_ranges
  project       = var.project
  #target_tags   = ["load-balanced-backend", "allow-health-check", "allow-ssh"]
  target_tags = var.target_tags

  allow {
    protocol = "tcp"
    #ports    = ["80", "8080", "443", "3306", "22"]
    ports  = var.fw_ports
  }

  allow {
    protocol = "udp"
  }

 allow {
    protocol = "icmp"
  }
  direction = "INGRESS"
} 

