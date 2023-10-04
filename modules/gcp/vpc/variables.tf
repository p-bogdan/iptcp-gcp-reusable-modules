
variable "project" {
default = ""
}

variable "region" {
default = ""
}

variable "network_name" {
description = "custom network name for gcp lab"
default = ""
}

variable "subnetwork_name" {
description = "custom subnetwork name for gcp lab"
default = ""
}

variable "auto_create_subnetworks" {
  type        = bool
  description = "When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources."
  default     = false

}

variable "routing_mode" {
  type        = string
  default     = "" 
  description = "The network routing mode (default 'GLOBAL')"
}

variable "delete_default_internet_gateway_routes" {
  type        = bool
  description = "If set, ensure that all routes within the network specified whose names begin with 'default-route' and with a next hop of 'default-internet-gateway' are deleted"
  default     = false
}

variable "ipv4_range_backends" {
default = ""
}

variable "source_ranges" {
type        = list(string)
description = "List of CIDR block ranges"
default      = [""]
}

variable "target-http-proxy_id" {
default = ""    
}
variable "fw_ports" {
type        = list(string)
description = "List of CIDR block ranges"
default      = [""]
}

variable "target_tags" {
type        = list(string)
description = "List of target tags to allow traffic"
default     = [""]
}
