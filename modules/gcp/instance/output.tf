output "instance-template" {
value = google_compute_instance_template.bookshelf-instance-template.self_link
}

output "instance-template_name" {
value = google_compute_instance_template.bookshelf-instance-template.name
}

output "instance_group_id" {
value = google_compute_region_instance_group_manager.bookshelf-app-group.id
}

output "instance_group_name" {
value = google_compute_region_instance_group_manager.bookshelf-app-group.name
}

output "instance_group_self_link" {
value = google_compute_region_instance_group_manager.bookshelf-app-group.self_link    
}

output "instance_group" {
value = google_compute_region_instance_group_manager.bookshelf-app-group.instance_group    
}

output "local_file" {
value = local_file.tf_ansible_vars_file
}  



output "tf_ansible_vars_file" {
value = local_file.tf_ansible_vars_file.filename
} 

output "named_port_name" {
value = var.named_ports.0.name  
} 
