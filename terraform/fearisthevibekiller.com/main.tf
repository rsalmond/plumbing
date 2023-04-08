provider "aws" {
  region  = "us-east-1"
  profile = "personal"
}

resource "aws_route53_zone" "fearisthevibekiller" {
  name = "fearisthevibekiller.com"
}

resource "aws_route53_record" "fearisthevibekiller" {
  zone_id = aws_route53_zone.fearisthevibekiller.zone_id
  name    = "${aws_route53_zone.fearisthevibekiller.name}"
  type    = "A"
  ttl     = "300"

  records = [
    var.brazen_ip
  ]
}

resource "aws_route53_record" "google_search_console" {
  zone_id = aws_route53_zone.fearisthevibekiller.zone_id
  name    = aws_route53_zone.fearisthevibekiller.name
  type    = "TXT"
  ttl     = "300"

  records = [
    "google-site-verification=L7TZOyIaivDnQ4fOT1qLO6_cdmMbl6eAxejlHkGNxkY"
  ]
}
