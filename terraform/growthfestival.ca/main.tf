provider "aws" {
  region  = "us-east-1"
  profile = "personal"
}

resource "aws_route53_zone" "growthfestival" {
  comment = "HostedZone created by Route53 Registrar"
  name = var.domain
}

resource "aws_route53_record" "mx" {
  zone_id = aws_route53_zone.growthfestival.zone_id
  name    = aws_route53_zone.growthfestival.name
  type    = "MX"
  ttl     = "300"

  records = [
    "10 mx1.improvmx.com",
    "20 mx2.improvmx.com",
  ]
}

resource "aws_route53_record" "txt" {
  zone_id = aws_route53_zone.growthfestival.zone_id
  name    = aws_route53_zone.growthfestival.name
  type    = "TXT"
  ttl     = "300"

  records = [
    "v=spf1 include:spf.improvmx.com ~all",
  ]
}

/*
resource "aws_route53_record" "pizza_a" {
  zone_id = aws_route53_zone.growthfestival.zone_id
  name    = aws_route53_zone.growthfestival.name
  type    = "A"
  ttl     = "300"

  records = [
    "89.106.200.1" // redirect.pizza
  ]
}

resource "aws_route53_record" "pizza_cname" {
  zone_id = aws_route53_zone.growthfestival.zone_id
  name    = "www.${aws_route53_zone.growthfestival.name}"
  type    = "CNAME"
  ttl     = "300"

  records = [
    "edge.redirect.pizza" // redirect.pizza
  ]
}*/
