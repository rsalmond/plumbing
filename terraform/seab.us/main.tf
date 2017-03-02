provider "aws" {
  region  = "us-east-1"
  profile = "seabus"
}

data "aws_route53_zone" "seabus" {
  name = "seab.us"
}

resource "aws_route53_record" "www" {
  #zone_id     = "Z38AGVFAO0JEIN"
  zone_id = "${data.aws_route53_zone.seabus.zone_id}"
  name    = "seab.us"
  type    = "A"
  ttl     = "300"
  records = ["107.161.27.162"]
}
