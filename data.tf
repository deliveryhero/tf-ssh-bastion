data "aws_ami" "default" {
  most_recent = true

  filter {
    name   = "name"
    values = ["${var.instance_ami_name_filter}"]
  }

  filter {
    name   = "owner-id"
    values = ["${var.instance_ami_owner_id_filter}"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}
