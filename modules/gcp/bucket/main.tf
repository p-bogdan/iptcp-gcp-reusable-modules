resource "google_storage_bucket" "bookshelf-data" {
  name = "bookshelf-app-data-${var.random_id_hex}"
#name = "bookshelf_app_data2"
  location      = var.location
}


resource "google_storage_default_object_access_control" "public_rule" {
  bucket = google_storage_bucket.bookshelf-data.name
  role   = "READER"
  entity = var.entity
  depends_on = [google_storage_bucket.bookshelf-data]
}

# resource "google_storage_bucket_acl" "image-store-acl" {
#   bucket = google_storage_bucket.bookshelf-data.name

#   role_entity = [
#     var.role_entity,
#   ]
# }