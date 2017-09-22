output "bucket_self_link" {
  value = "${google_storage_bucket.remote_state.self_link}"
}

