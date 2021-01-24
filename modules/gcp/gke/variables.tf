variable "zone" {
    default = ""
}

variable "project" {
    default = ""
}

variable "remove_default_node_pool" {
    type = bool
    default = true
}

variable "preemptible" {
    type = bool
    default = false
}

variable "issue_client_certificate" {
    type = bool
    default = false
}

variable "cluster_name" {
    default = ""
}

variable "node_count" {
    default = ""
}

variable "machine_type" {
  default = "n1-standard-1"
}
variable "disk_size_gb" {
    default = 10
}
variable "auto_repair" {
    type = bool
    default = true
}

variable "auto_upgrade" {
    default = false
}

variable "cluster_version" {
    default = ""
}
