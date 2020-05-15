terraform {
  backend "s3" {
    profile = "personal"
    bucket  = "plumbing-tf-state"
    key     = "doubleg.in/terraform.tfstate"
    region  = "us-east-1"
  }
}
