provider "aws" {
  region  = "us-east-1"
  profile = "personal"
}

resource "aws_route53_zone" "hexlace" {
  comment = "HostedZone created by Route53 Registrar"
  name = var.domain
}


resource "aws_route53domains_registered_domain" "hexlace" {
  domain_name = var.domain

  name_server {
    name = "anirban.ns.cloudflare.com"
  }

  name_server {
    name = "dolly.ns.cloudflare.com"
  }
}

// begin carrd.co config

resource "aws_route53_record" "hexlace" {
  zone_id = aws_route53_zone.hexlace.zone_id
  name    = aws_route53_zone.hexlace.name
  type    = "A"
  ttl     = "300"

  records = [
    var.carrd_ip
  ]
}

resource "aws_route53_record" "hexlace_cname" {
  zone_id = aws_route53_zone.hexlace.zone_id
  name = "www.${aws_route53_zone.hexlace.name}"
  type = "CNAME"
  ttl = "300"
  records = [
    "${var.domain}."
  ]
}

// end carrd.co config
