terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "personal"
}

resource "aws_route53_zone" "salmond_ca" {
  name = "salmond.ca"
}

resource "aws_route53_record" "rob_salmond_ca" {
  zone_id = aws_route53_zone.salmond_ca.zone_id
  name    = "rob.${aws_route53_zone.salmond_ca.name}"
  type    = "A"
  ttl     = "300"

  records = [
    var.brazen_ip
  ]
}

resource "aws_route53_record" "svcb" {
  zone_id = aws_route53_zone.salmond_ca.zone_id
  name    = "rob.${aws_route53_zone.salmond_ca.name}"
  type    = "SVCB"
  ttl     = "300"

  records = [
    "1 rob.salmond.ca alpn=h2"
  ]
}

resource "aws_route53_record" "https" {
  zone_id = aws_route53_zone.salmond_ca.zone_id
  name    = "rob.${aws_route53_zone.salmond_ca.name}"
  type    = "HTTPS"
  ttl     = "300"

  records = [
    "1 rob.salmond.ca alpn=h2"
  ]
}

resource "aws_route53_record" "keybase" {
  zone_id = aws_route53_zone.salmond_ca.zone_id
  name    = aws_route53_zone.salmond_ca.name
  type    = "TXT"
  ttl     = "300"

  records = [
    "keybase-site-verification=nbjNfHKEJbQ7ysooVytqqDdE3NKbYxIGWsvMnnBeelI",
    "v=spf1 include:_spf.google.com include:fearisthevibekiller.com ~all"
  ]
}

resource "aws_route53_record" "mx" {
  zone_id = aws_route53_zone.salmond_ca.zone_id
  name    = aws_route53_zone.salmond_ca.name
  type    = "MX"
  ttl     = "300"

  records = [
    "10 ALT2.ASPMX.L.GOOGLE.COM",
    "10 ASPMX.L.GOOGLE.COM",
    "10 ALT1.ASPMX.L.GOOGLE.COM",
  ]
}

resource "aws_route53_record" "terry" {
  zone_id = aws_route53_zone.salmond_ca.zone_id
  name    = "terry.${aws_route53_zone.salmond_ca.name}"
  type    = "A"
  ttl     = "300"
  records = [var.webware_ip]
}

resource "aws_route53_record" "terry_www" {
  zone_id = aws_route53_zone.salmond_ca.zone_id
  name    = "www.terry.${aws_route53_zone.salmond_ca.name}"
  type    = "CNAME"
  ttl     = "300"
  records = ["lb.webware.io"]
}
