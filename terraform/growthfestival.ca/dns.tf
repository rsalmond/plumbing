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

/* notion hosting */

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.growthfestival.zone_id
  name    = "www.${aws_route53_zone.growthfestival.name}"
  type    = "CNAME"
  ttl     = "300"

  records = [
    "external.notion.site"
  ]
}

resource "aws_route53_record" "notion_txt" {
  zone_id = aws_route53_zone.growthfestival.zone_id
  name    = "_notion-dcv.www.${aws_route53_zone.growthfestival.name}"
  type    = "TXT"
  ttl     = "300"

  records = [
    "1ea8199c-d59f-8196-97b6-0070b5930d6f"
  ]
}

/* stupid bucket redirect trick */

resource "aws_route53_record" "redirect" {
  zone_id = aws_route53_zone.growthfestival.zone_id
  name    = aws_route53_zone.growthfestival.name
  type    = "A"

  alias {
    name                   = "s3-website-us-east-1.amazonaws.com" /* magic!? */
    zone_id                = aws_s3_bucket.redirect.hosted_zone_id
    evaluate_target_health = true
  }

}
