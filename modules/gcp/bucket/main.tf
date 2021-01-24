resource "google_storage_bucket" "bookshelf-data" {
  name = "bookshelf-app-data-${var.random_id_hex}"
  location      = var.location
}


resource "google_storage_default_object_access_control" "public_rule" {
  bucket = google_storage_bucket.bookshelf-data.name
  role   = "READER"
  entity = var.entity
  depends_on = [google_storage_bucket.bookshelf-data]
}