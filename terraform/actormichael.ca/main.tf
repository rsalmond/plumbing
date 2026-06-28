provider "aws" {
  region  = "us-east-1"
  profile = "personal"
}

// am => actor michael

resource "aws_route53_zone" "am" {
  comment = "HostedZone created by Route53 Registrar"
  name = var.domain
}

// begin carrd.co config

resource "aws_route53_record" "rob_salmond_ca" {
  zone_id = aws_route53_zone.am.zone_id
  name    = aws_route53_zone.am.name
  type    = "A"
  ttl     = "300"

  records = [
    var.carrd_ip
  ]
}

resource "aws_route53_record" "sendgrid0" {
  zone_id = aws_route53_zone.am.zone_id
  name = "www.${aws_route53_zone.am.name}"
  type = "CNAME"
  ttl = "300"
  records = [
    "actormichael.ca."
  ]
}

// end carrd.co config

/*
resource "aws_route53_record" "mx" {
  zone_id = aws_route53_zone.am.zone_id
  name    = aws_route53_zone.am.name
  type    = "MX"
  ttl     = "300"

  records = [
    "10 mx1.improvmx.com",
    "20 mx2.improvmx.com",
  ]
}

resource "aws_route53_record" "txt" {
  zone_id = aws_route53_zone.am.zone_id
  name    = aws_route53_zone.am.name
  type    = "TXT"
  ttl     = "300"

  records = [
    "v=spf1 include:spf.improvmx.com ~all",
  ]
}*/
