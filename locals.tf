locals {
  instance_ami_id   = "${var.instance_ami_id == "" ? "${data.aws_ami.default.id}" : var.instance_ami_id}"
  resource_name     = "${var.resource_name_prefix}${var.name}${var.resource_name_suffix}"
  sid_resource_name = "${replace(replace(local.resource_name, "_", ""), "-", "")}"
  asg_tags          = ["${null_resource.tags_as_list_of_maps.*.triggers}"]
}
