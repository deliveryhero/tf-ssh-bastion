data "aws_ami" "default" {
  most_recent = true
  owners      = ["${var.instance_ami_owner_id_filter}"]

  filter {
    name   = "name"
    values = ["${var.instance_ami_name_filter}"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

data "template_file" "bastion_setup_init" {
  template = "${file("${path.module}/user_data/setup_init.sh")}"

  vars {
    INSTANCE_HOSTNAME = "${local.instance_hostname}"
  }
}

data "template_file" "bastion_associate_eip" {
  template = "${file("${path.module}/user_data/associate_eip.sh")}"

  vars {
    EIP_ALLOCATION_ID = "${aws_eip.bastion.id}"
  }
}

data "template_file" "users" {
  template = "${file("${path.module}/user_data/add_users.sh")}"

  vars {
    data = "${join("", data.template_file.user_config_commands.*.rendered)}"
  }
}

data "template_file" "user_config_commands" {
  count    = "${length(var.users)}"
  template = "${file("${path.module}/user_data/user_config_commands.sh")}"

  vars {
    group    = "${lookup(var.users[count.index], "group")}"
    username = "${lookup(var.users[count.index], "username")}"
    key      = "${lookup(var.users[count.index], "key")}"
  }
}
