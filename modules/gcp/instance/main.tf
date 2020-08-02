####################

# Instance Template

####################



resource "google_compute_instance_template" "bookshelf-instance-template" {

  name                    = var.instance_template_name

  machine_type            = var.machine_type

  tags                    = var.intance_template_tags

  depends_on = [var.google_sql_instance, var.google_sql_database]


metadata_startup_script    = file("${path.root}/scripts/${var.startup-script}")



  region                  = var.region

  disk {

        auto_delete  = var.auto_delete

        disk_size_gb = var.disk_size_gb

        disk_type    = var.disk_type

 
       source_image = var.source_image

  }

  service_account {

    email  = "terraform-sa@gcp-training-iptcp.iam.gserviceaccount.com"

    scopes = ["cloud-platform"]

  }



#Uncomment this block if you want to allocate external IP to your instance

/*     network_interface {

    network            = var.network_name

    subnetwork         = var.subnetwork_id

#    network_ip         = var.instance_network_ip

#    subnetwork_project = var.project

   } */

   

 dynamic "network_interface" {

    for_each = var.network_interfaces

    content {

      network = lookup(network_interface.value, "network", null)

      subnetwork = lookup(network_interface.value, "subnetwork", null)

      network_ip = lookup(network_interface.value, "network_ip", null)

    }

  } 

}
 
# Render the Ansible var_file containing Terrarorm variable values

       resource "local_file" "tf_ansible_vars_file" {

   #  content  = base64encode(yamlencode(

    content  = yamlencode(

    {

      #project_id         = var.project

      cloud_sql_password = var.sql_user_password

      connection_name    = var.sql_instance_connection_name

      storage_bucket     = var.bookshelf-app-bucket

      data_backend       = var.data_backend

 

    }

  )

  filename = "${path.root}/ansible/${var.tf_ansible_vars_file}"

}      

resource "google_compute_region_instance_group_manager" "bookshelf-app-group" {

  name = var.instance_group_name

  #region = var.region



#  base_instance_name         = var.instance-template_name

   base_instance_name         = var.instance_template_name

 # region                     = var.region

  distribution_policy_zones  = ["europe-west1-b"]

 # target_size = 1


  target_size = 1


  depends_on = [google_compute_instance_template.bookshelf-instance-template]



  version {

    

   name              = "primary"

    # instance_template = var.instance-template

     instance_template = google_compute_instance_template.bookshelf-instance-template.self_link

  }

  #In order to extract name variable for backend dynamic variable is good approach

    dynamic "named_port" {

    for_each = var.named_ports

    content {

      name = lookup(named_port.value, "name", null)

      port = lookup(named_port.value, "port", null)

    }

  } 

}




resource "google_compute_region_autoscaler" "instances-autoscaler" {

  name     = "${var.instance_template_name}-autoscaler"


  #region   = var.region

  target   = google_compute_region_instance_group_manager.bookshelf-app-group.id

  depends_on = [google_compute_region_instance_group_manager.bookshelf-app-group]

  autoscaling_policy {

    max_replicas    = var.max_replicas

    min_replicas    = var.min_replicas

    cooldown_period = var.cooldown_period

  cpu_utilization {

    #  target = 0.8 

    #Changed for testing autoscaling

       target = 0.2

    }

    }

   }


