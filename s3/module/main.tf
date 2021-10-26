
provider "aws" {
  region = var.region
  profile = var.profile
}


module "bucket" {
  source="github.com/terraform-aws-modules/terraform-aws-s3-bucket?ref=v2.9.0"

  for_each = var.buckets

  bucket = each.key
  bucket_prefix	= try(each.value.bucket_prefix, null)

  acl = try(each.value.acl,"private")
  acceleration_status	= try(each.value.acceleration_status, null)

  attach_deny_insecure_transport_policy	= try(each.value.attach_deny_insecure_transport_policy, false)
  attach_elb_log_delivery_policy = try(each.value.attach_elb_log_delivery_policy, false)
  attach_lb_log_delivery_policy = try(each.value.attach_lb_log_delivery_policy, false)
  attach_policy = try(each.value.attach_policy, false)
  attach_public_policy = try(each.value.attach_public_policy, false)

  block_public_acls	= try(each.value.block_public_acls, false)
  block_public_policy	 = try(each.value.block_public_policy, false)

  control_object_ownership = try(each.value.control_object_ownership, false)
  cors_rule	= try(each.value.cors_rule, [])
  create_bucket	= try(each.value.create_bucket, true)

  force_destroy	= try(each.value.force_destroy, false)

  grant	= try(each.value.grant, [])

  ignore_public_acls = try(each.value.ignore_public_acls, false)

  lifecycle_rule = try(each.value.lifecycle_rule, [])
  logging	= try(each.value.logging, {})

  object_lock_configuration	= try(each.value.control_object_ownership, {})
  object_ownership = try(each.value.control_object_ownership, "ObjectWriter")

  policy = try(each.value.control_object_ownership, null)

  replication_configuration	= try(each.value.control_object_ownership, {})
  request_payer	= try(each.value.control_object_ownership, null)

  restrict_public_buckets	= try(each.value.control_object_ownership, false)
  server_side_encryption_configuration = try(each.value.control_object_ownership, {})

  versioning = try(each.value.control_object_ownership, {})
  website	= try(each.value.control_object_ownership, {})

  tags = try(merge(var.tags, each.value.tags), var.tags)
}

