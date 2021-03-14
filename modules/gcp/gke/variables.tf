variable "zone" {
    default = ""
}

variable "project" {
    default = ""
}

variable "remove_default_node_pool" {
    type = bool
    default = ""
}

variable "preemptible" {
    type = bool
    default = ""
}

variable "issue_client_certificate" {
    type = bool
    default = ""
}

variable "cluster_name" {
    default = ""
}

variable "node_count" {
    default = ""
}


variable "machine_type" {
  default = ""
}
variable "disk_size_gb" {
    default = ""
}
variable "auto_repair" {
    type = bool
    default = ""
}

variable "auto_upgrade" {
    default = ""
}

variable "cluster_version" {
    default = ""
}

variable "env" {
    default = ""
}