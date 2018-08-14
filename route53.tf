resource "aws_route53_record" "bastion" {
  count   = "${var.route53_zone_id == "" ? 0 : 1}"
  zone_id = "${var.route53_zone_id}"
  name    = "${var.route53_record_prefix}${local.resource_name}${var.route53_record_suffix}"
  type    = "A"
  ttl     = "${var.route53_record_ttl}"
  records = ["${aws_eip.bastion.public_ip}"]
}
