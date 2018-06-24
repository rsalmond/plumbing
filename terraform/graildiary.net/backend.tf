terraform {
  backend "s3" {
    bucket  = "plumbing-tf-state"
    key     = "graildiary.net/terraform.tfstate"
    region  = "us-east-1"
    profile = "personal"
  }
}
