variable "zone" {
    default = ""
}

variable "gke_tags" {
type        = list(string)
description = "List of gke tags to allow traffic"
default     = [""]
}


variable "project" {
    default = ""
}

variable "remove_default_node_pool" {
    type = bool
}

variable "preemptible" {
    type = bool
}

variable "issue_client_certificate" {
    type = bool
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

variable "network" {
default = ""
}

variable "subnetwork" {
default = ""
}
