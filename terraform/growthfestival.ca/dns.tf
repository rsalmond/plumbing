provider "aws" {
  region  = "us-east-1"
  profile = "personal"
}

resource "aws_route53_zone" "growthfestival" {
  comment = "HostedZone created by Route53 Registrar"
  name    = var.domain
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

/* github hosting */

resource "aws_route53_record" "github_pages" {
  zone_id = aws_route53_zone.growthfestival.zone_id
  name    = "${aws_route53_zone.growthfestival.name}"
  type    = "A"
  ttl     = "300"

  records = [
    "185.199.108.153",
    "185.199.109.153",
    "185.199.110.153",
    "185.199.111.153",
  ]
}

resource "aws_route53_record" "github_pages_ipv6" {
  zone_id = aws_route53_zone.growthfestival.zone_id
  name    = "${aws_route53_zone.growthfestival.name}"
  type    = "AAAA"
  ttl     = "300"

  records = [
    "2606:50c0:8000::153",
    "2606:50c0:8001::153",
    "2606:50c0:8002::153",
    "2606:50c0:8003::153",
  ]
}

resource "aws_route53_record" "www_github_pages" {
  zone_id = aws_route53_zone.growthfestival.zone_id
  name    = "www.${aws_route53_zone.growthfestival.name}"
  type    = "CNAME"
  ttl     = "300"

  records = ["rsalmond.github.io"]
}
