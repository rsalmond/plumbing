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

resource "aws_route53_record" "box_salmond_ca" {
  zone_id = aws_route53_zone.salmond_ca.zone_id
  name    = "box.${aws_route53_zone.salmond_ca.name}"
  type    = "A"
  ttl     = "300"

  records = [
    var.vps_ip,
  ]
}

resource "aws_route53_record" "keybase" {
  zone_id = aws_route53_zone.salmond_ca.zone_id
  name    = aws_route53_zone.salmond_ca.name
  type    = "TXT"
  ttl     = "300"

  records = [
    "keybase-site-verification=nbjNfHKEJbQ7ysooVytqqDdE3NKbYxIGWsvMnnBeelI",
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

resource "aws_route53_record" "test_salmond_ca" {
  zone_id = aws_route53_zone.salmond_ca.zone_id
  name    = "test.${aws_route53_zone.salmond_ca.name}"
  type    = "A"
  ttl     = "300"

  records = [
    var.brazen_ip
  ]
}
