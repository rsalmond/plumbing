provider "aws" {
  region  = "us-east-1"
  profile = "personal"
}

data "aws_route53_zone" "graildiary" {
  name = "graildiary.net"
}

resource "aws_route53_record" "www" {
  zone_id = "${data.aws_route53_zone.graildiary.zone_id}"
  name    = "graildiary.net"
  type    = "A"
  ttl     = "60"

  records = [
    "${var.vps_ip}",
  ]
}
