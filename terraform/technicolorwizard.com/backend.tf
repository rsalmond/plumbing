terraform {
  backend "s3" {
    profile = "personal"
    bucket  = "plumbing-tf-state"
    key     = "technicolorwizard.com/terraform.tfstate"
    region  = "us-east-1"
  }
}
