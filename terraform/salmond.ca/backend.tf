terraform {
  backend "s3" {
    profile = "personal"
    bucket  = "plumbing-tf-state"
    key     = "salmond.ca/terraform.tfstate"
    region  = "us-east-1"
  }
}
