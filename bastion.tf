resource "aws_eip" "bastion" {
  vpc  = true
  tags = "${merge(var.tags, map("Name", "${local.resource_name}"))}"
}

resource "aws_autoscaling_group" "bastion" {
  name                 = "${local.resource_name}"
  vpc_zone_identifier  = ["${var.public_subnet_ids}"]
  max_size             = 1
  min_size             = 1
  desired_capacity     = 1
  launch_configuration = "${aws_launch_configuration.bastion.name}"

  tags = [
    "${map("key", "Name", "value", "${local.resource_name}", "propagate_at_launch", true)}",
    "${local.asg_tags}",
  ]
}

data "template_file" "bastion_setup_init" {
  template = "${file("${path.module}/user_data/setup_init.sh")}"
}

data "template_file" "bastion_associate_eip" {
  template = "${file("${path.module}/user_data/associate_eip.sh")}"

  vars {
    EIP_ALLOCATION_ID = "${aws_eip.bastion.id}"
  }
}

resource "aws_launch_configuration" "bastion" {
  name_prefix   = "${local.resource_name}-"
  image_id      = "${local.instance_ami_id}"
  instance_type = "${var.instance_type}"

  security_groups = [
    "${aws_security_group.bastion.id}",
    "${var.extra_sg_ids}",
  ]

  key_name             = "${var.instance_key_name}"
  iam_instance_profile = "${aws_iam_instance_profile.bastion.arn}"

  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.instance_volume_size}"
  }

  user_data = "${data.template_file.bastion_setup_init.rendered}${data.template_file.bastion_associate_eip.rendered}${var.extra_user_data}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "null_resource" "tags_as_list_of_maps" {
  count = "${length(keys(var.tags))}"

  triggers = "${map(
    "key", "${element(keys(var.tags), count.index)}",
    "value", "${element(values(var.tags), count.index)}",
    "propagate_at_launch", "true"
  )}"
}
