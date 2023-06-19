terraform {
  backend "s3" {
    profile = "personal"
    bucket  = "plumbing-tf-state"
    key     = "progredo.ca/terraform.tfstate"
    region  = "us-east-1"
  }
}
