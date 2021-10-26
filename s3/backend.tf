terraform {
  backend "s3" {
    key    = "s3"
    workspace_key_prefix = "env"
  }
}