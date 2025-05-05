resource "aws_s3_bucket" "redirect" {
  bucket = "growthfestival.ca"
}

resource "aws_s3_bucket_website_configuration" "redirect" {
  bucket = aws_s3_bucket.redirect.id
  redirect_all_requests_to {
    host_name = "www.growthfestival.ca"
    protocol  = "http"
  }
}
