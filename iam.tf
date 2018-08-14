resource "aws_iam_instance_profile" "bastion" {
  name = "${local.resource_name}"
  role = "${aws_iam_role.bastion.name}"
}

resource "aws_iam_role" "bastion" {
  name               = "${local.resource_name}"
  assume_role_policy = "${data.aws_iam_policy_document.bastion_assume_role_policy.json}"
}

data "aws_iam_policy_document" "bastion_assume_role_policy" {
  statement {
    sid = "${local.sid_resource_name}AssumeRolePolicy"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "bastion" {
  policy_arn = "${aws_iam_policy.bastion.arn}"
  role       = "${aws_iam_role.bastion.name}"
}

resource "aws_iam_policy" "bastion" {
  name_prefix = "${local.resource_name}"
  description = "Policy for bastion ${var.name}"
  policy      = "${data.aws_iam_policy_document.bastion.json}"
}

data "aws_iam_policy_document" "bastion" {
  statement {
    sid    = "${local.sid_resource_name}"
    effect = "Allow"

    actions = [
      "ec2:AssociateAddress",
      "ec2:DescribeAddresses",
      "ec2:DisassociateAddress",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy_attachment" "extra" {
  count      = "${length(var.extra_iam_policy_arns)}"
  policy_arn = "${element(var.extra_iam_policy_arns, count.index)}"
  role       = "${aws_iam_role.bastion.name}"
}
