terraform {
  backend "s3" {
    profile = "personal"
    bucket  = "plumbing-tf-state"
    key     = "growthfestival.ca/terraform.tfstate"
    region  = "us-east-1"
  }
}
