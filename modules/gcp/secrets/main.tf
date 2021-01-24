
 resource "google_secret_manager_secret" "secret-basic" {
  depends_on = [var.local_file]
  secret_id = "tf-ansible-vars"
  
  labels = {
    label = "tf-ansible-vars"
  }

   replication {
    automatic = true
  } 
}

resource "google_secret_manager_secret_version" "secret-version-basic" {
   depends_on = [var.local_file]
   secret = google_secret_manager_secret.secret-basic.id
   secret_data = file(base64decode(var.tf_ansible_vars_file))
}

 
