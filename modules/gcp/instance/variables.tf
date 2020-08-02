variable "region" {
default = ""
}

  variable "project" {
  default = ""
} 

variable "instance_template_name" {

  description = "Name prefix for the instance template"

  default     = "bookshelf-app-template"

}

variable "machine_type" {

  description = "Machine type to create, e.g. n1-standard-1"

  default     = "n1-standard-1"

}

variable "email" {
  default = ""
}

variable "network_name" {

default = ""

}

variable "subnetwork_id" {

default = ""    

}

variable "google_sql_instance" {

default = ""   

}



variable "google_sql_database" {

default = ""

}

variable "bookshelf-app-bucket" {

  default = ""

}

###########

#Instance template metadata

###########



  variable "startup-script" {

  default = "" 

 } 

###ANSIBLE VARS#########################

     variable "tf_ansible_vars_file" {

  default = "tf_ansible_vars.yml"

}  

   

 variable "sql_user_password" {

  default = ""

}



variable "file_permission" {

  default = "0777"

}



variable "dir_permission" {

  default = "0777"

}


variable "sql_instance_connection_name" {

  default = ""

}



variable "sql_database_name" {

  default = ""

}



variable "data_backend" {

default = "cloudsql"

}



variable "storage_bucket" {

  default = "gcp-lab-training-bucket"

}



#############################################

variable "intance_template_tags" {

  type        = list(string)

  description = "Network tags, provided as a list"

  default     = ["allow-ssh", "load-balanced-backend", "allow-health-check"]

}

#######

# disk parameters

#######



variable "auto_delete" {

  description = "Whether or not the boot disk should be auto-deleted"

  default     = "true"

}

variable "disk_size_gb" {

  description = "Boot disk size in GB"

  default     = "10"

}

variable "disk_type" {

  description = "Boot disk type, can be either pd-ssd, local-ssd, or pd-standard"

  default     = "pd-standard"

}

variable "source_image" {

  description = "Source disk image. If neither source_image nor source_image_family is specified, defaults to the latest public CentOS image."

  default     = "debian-cloud/debian-10"

}


variable "instance_group_name" {

default = "bookshelf-app-mig"   

}

 

variable "network_interfaces" {

  type = list(object({

    network    = string

    subnetwork = string

    network_ip = string

  }))

  default = [

    {

      network       = "gcp-lab-network"

      subnetwork    = "gcp-lab-backend-subnet"

      network_ip    = ""

    },

  ]

}

variable "named_ports" {

  description = "Named name and named port. https://cloud.google.com/load-balancing/docs/backend-service#named_ports"

  type = list(object({

    name = string

    port = number

  }))

  default = [

    {

      name       = "bookshelf-mig-named-port" 

      port       = 8080

    },

  ]

}

variable "healthcheck_self_link" {

default = ""

}



# Autoscaler

#############

variable "autoscaling_enabled" {

  description = "Creates an autoscaler for the managed instance group"

#  default     = "false"

 default = "true"

}

variable size {

  description = "Target size of the managed instance group."

  default     = 1

}

variable "max_replicas" {

  description = "The maximum number of instances that the autoscaler can scale up to. This is required when creating or updating an autoscaler. The maximum number of replicas should not be lower than minimal number of replicas."

  default     = 2

}

variable "min_replicas" {

  description = "The minimum number of replicas that the autoscaler can scale down to. This cannot be less than 0."

  default     = 1

}



variable "cooldown_period" {

  description = "The number of seconds that the autoscaler should wait before it starts collecting information from a new instance."

#  default     = 60

  default = 180

} 

