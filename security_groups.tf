resource "aws_security_group_rule" "allow_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "TCP"
  cidr_blocks       = "${var.allowed_ssh_cidr_blocks}"
  security_group_id = "${aws_security_group.bastion.id}"
}

resource "aws_security_group" "bastion" {
  name_prefix = "${local.resource_name}"
  vpc_id      = "${var.vpc_id}"
  description = "Bastion ${var.name}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(var.tags, map("Name", "${local.resource_name}"))}"
}

resource "aws_security_group" "allow_ssh_from_bastion" {
  name        = "allow-ssh-from-${local.resource_name}"
  vpc_id      = "${var.vpc_id}"
  description = "Allows SSH from ${var.name}"

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${aws_security_group.bastion.id}"]
  }

  tags = "${merge(var.tags, map("Name", "allow-ssh-from-${local.resource_name}"))}"
}
