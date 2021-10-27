

locals {
  files = fileset(path.module, "${terraform.workspace}/*.yaml")
  buckets = merge([for file in local.files: yamldecode(file(file)) ]...)
  environment = yamldecode(file("/env/${terraform.workspace}.yaml"))
}

module "set" {
  source = "./module"
  buckets = local.buckets
  region = local.environment.region
  profile = local.environment.profile
  tags = local.environment.tags
}

output "buckets" {
  value = module.set.buckets
}

