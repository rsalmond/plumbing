provider "aws" {
  region  = "us-east-1"
  profile = "personal"
}

data "aws_route53_zone" "progredo_ca" {
  name = "progredo.ca"
}

resource "aws_route53_record" "mx" {
  zone_id = data.aws_route53_zone.progredo_ca.zone_id
  name    = data.aws_route53_zone.progredo_ca.name
  type    = "MX"
  ttl     = "300"

  records = [
    "1 smtp.google.com",
  ]
}

resource "aws_route53_record" "spf" {
  zone_id = data.aws_route53_zone.progredo_ca.zone_id
  name    = data.aws_route53_zone.progredo_ca.name
  type    = "TXT"
  ttl     = "300"

  records = [
    "v=spf1 include:spf.improvmx.com ~all",
    "google-site-verification=4fxmEud9OKFp3Pdc_weSJv49kgLYdTM3GoQgZ9UE2w0"
  ]
}

resource "aws_route53_record" "dmarc" {
  zone_id = data.aws_route53_zone.progredo_ca.zone_id
  name    = "_dmarc.${data.aws_route53_zone.progredo_ca.name}"
  type    = "TXT"
  ttl     = "300"

  records = [
    "v=DMARC1; p=none;"
  ]
}

resource "aws_route53_record" "dkim1" {
  zone_id = data.aws_route53_zone.progredo_ca.zone_id
  name    = "dkimprovmx1._domainkey.${data.aws_route53_zone.progredo_ca.name}"
  type    = "CNAME"
  ttl     = "300"

  records = [
    "dkimprovmx1.improvmx.com"
  ]
}

resource "aws_route53_record" "dkim2" {
  zone_id = data.aws_route53_zone.progredo_ca.zone_id
  name    = "dkimprovmx2._domainkey.${data.aws_route53_zone.progredo_ca.name}"
  type    = "CNAME"
  ttl     = "300"

  records = [
    "dkimprovmx2.improvmx.com"
  ]
}
