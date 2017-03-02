provider "aws" {
  region  = "us-east-1"
  profile = "personal"
}

resource "aws_route53_zone" "leesblog_com" {
  name = "leesblog.com"
}

resource "aws_route53_record" "www_leesblog_com" {
  zone_id = "${aws_route53_zone.leesblog_com.zone_id}"
  name    = "www.${aws_route53_zone.leesblog_com.name}"
  type    = "CNAME"
  ttl     = "300"

  records = [
    "https://twitter.com/leeplaysblues",
  ]
}
