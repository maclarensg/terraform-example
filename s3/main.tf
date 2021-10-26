

locals {
  files = fileset(path.module, "${terraform.workspace}/*.yaml")
  buckets = merge([for file in local.files: yamldecode(file(file)) ]...)
  enviroment = yamldecode(file("/env/${terraform.workspace}.yaml"))
}

module "set" {
  source = "./module"
  buckets = local.buckets
  region = local.enviroment.region
  profile = local.enviroment.profile
  tags = local.enviroment.tags
}

output "buckets" {
  value = module.set.buckets
}

