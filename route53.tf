resource "aws_route53_record" "bastion" {
  count   = var.create_route53 == true ? 1 : 0
  zone_id = var.route53_zone_id
  name    = var.route53_record_name == "" ? var.name : var.route53_record_name
  type    = "A"
  ttl     = var.route53_record_ttl
  records = [aws_eip.bastion.public_ip]
}

