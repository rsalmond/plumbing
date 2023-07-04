provider "aws" {
  region  = "us-east-1"
  profile = "personal"
}

data "aws_route53_zone" "doubleg_in" {
  name = "doubleg.in."
}

resource "aws_route53_record" "mx" {
  zone_id = data.aws_route53_zone.doubleg_in.zone_id
  name    = data.aws_route53_zone.doubleg_in.name
  type    = "MX"
  ttl     = "300"

  records = [
    "10 mx1.improvmx.com",
    "10 mx2.improvmx.com",
  ]
}

resource "aws_route53_record" "txt" {
  zone_id = data.aws_route53_zone.doubleg_in.zone_id
  name    = data.aws_route53_zone.doubleg_in.name
  type    = "TXT"
  ttl     = "300"

  records = [
    "v=spf1 include:spf.improvmx.com ~all",
  ]
}
