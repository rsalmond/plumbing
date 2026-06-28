terraform {
  backend "s3" {
    profile = "personal"
    bucket  = "plumbing-tf-state"
    key     = "actormichael.ca/terraform.tfstate"
    region  = "us-east-1"
  }
}
