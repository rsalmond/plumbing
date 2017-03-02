provider "aws" {
  region  = "us-east-1"
  profile = "personal"
}

resource "aws_route53_zone" "phro_me" {
  name = "phro.me"
}

resource "aws_route53_record" "phro_me" {
  zone_id = "${aws_route53_zone.phro_me.zone_id}"
  name    = "${aws_route53_zone.phro_me.name}"
  type    = "A"
  ttl     = "300"

  records = [
    "${var.vps_ip}",
  ]
}
