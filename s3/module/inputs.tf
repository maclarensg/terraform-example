variable "buckets" {
  type = map
  description = "(Required) Map of bucket definition"
}

variable "region" {
  type = string
  description = "(Required) AWS Region for provider"
}

variable "profile" {
  type = string
  description = "(Required) AWS Profile for provider"
}

variable "tags" {
  type = map
  description = "(Optional) Tags for resources"
  default = {}
}
