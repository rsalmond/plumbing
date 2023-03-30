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
