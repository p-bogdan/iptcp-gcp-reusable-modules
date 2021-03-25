resource "google_storage_bucket" "bucket" {
  #name = "bookshelf-app-data-${var.random_id_hex}"
  name = var.bucket_name
  location      = var.location
  uniform_bucket_level_access = false
  force_destroy = true
}


resource "google_storage_default_object_access_control" "public_rule" {
  bucket = google_storage_bucket.bucket.name
  role   = var.access_bucket_role
  entity = var.entity
  depends_on = [google_storage_bucket.bucket]
}
