output "buckets" {
  value = { for b, v in module.bucket: b => v }
}