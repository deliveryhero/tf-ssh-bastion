output "bastion_sg_id" {
  value       = "${aws_security_group.bastion.id}"
  description = "The security group of the bastion instance"
}

output "allow_ssh_from_bastion_sg_id" {
  value       = "${aws_security_group.allow_ssh_from_bastion.id}"
  description = "Put instances into this security group to allow SSH from the bastion"
}

output "bastion_aws_iam_role_id" {
  value       = "${aws_iam_role.bastion.id}"
  description = "Name of the bastion inance role"
}

output "bastion_aws_iam_role_arn" {
  value       = "${aws_iam_role.bastion.arn}"
  description = "ARN of the bastion instance role"
}

output "eip" {
  value       = "${aws_eip.bastion.public_ip}"
  description = "The elastic IP that is assigned to the bastion instance"
}

output "autoscaling_group_name" {
  value       = "${aws_autoscaling_group.bastion.name}"
  description = "Name of the autoscaling group"
}

output "bastion_user_data_full" {
  value       = "${local.lc_user_data}"
  description = "The complete user-data from the bastion instance"
}

output "bastion_user_data_users" {
  value       = "${data.template_file.users.rendered}"
  description = "The useradd and SSH key setup part of the user-data from the bastion instance"
}
