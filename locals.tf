locals {
  instance_ami_id   = "${var.instance_ami_id == "" ? "${data.aws_ami.default.id}" : var.instance_ami_id}"
  resource_name     = "${var.resource_name_prefix}${var.name}${var.resource_name_suffix}"
  sid_resource_name = "${replace(replace(local.resource_name, "_", ""), "-", "")}"
  asg_tags          = ["${null_resource.tags_as_list_of_maps.*.triggers}"]
  lc_user_data      = "${data.template_file.bastion_setup_init.rendered}${data.template_file.bastion_associate_eip.rendered}${data.template_file.users.rendered}${var.extra_user_data}"

  # This is to force the recreation of the autoscaling group when user-data changes
  asg_name_id_suffix = "${md5(local.lc_user_data)}"
}
