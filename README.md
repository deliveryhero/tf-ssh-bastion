# SSH bastion

Creates an autoscaling group, security groups, IAM policy, elastic IP and user-data to automatically assign the elastic IP. This ensures an SSH bastion is always present with the same public IP address.

## Example

```hcl
module "bastion1" {
  source                  = "github.com/deliveryhero/tf-ssh-bastion"
  name                    = "staging"
  vpc_id                  = "vpc123456"
  instance_key_name       = "my-ec2-key"
  allowed_ssh_cidr_blocks = [
    "203.1.2.3/32",
    "203.4.5.6/32",
  ]
  route53_zone_id         = "EXAMPLE12345"
  public_subnet_ids       = ["${module.vpc1.public_subnets}"]
  tags = {
    terraform   = "true"
    environment = "staging"
  }
}
```

## Documentation generation

Documentation should be modified within `main.tf` and generated using [terraform-docs](https://github.com/segmentio/terraform-docs):

```bash
terraform-docs md ./ | cat -s | tail -r | tail -n +2 | tail -r > README.md
```

## License

MIT Licensed. See [LICENSE](https://github.com/deliveryhero/tf-ssh-bastion/tree/master/LICENSE) for full details.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| allowed_ssh_cidr_blocks | CIDR blocks to allow SSH from. Should be set to your trusted IP or IP ranges | list | `<list>` | no |
| extra_iam_policy_arns | List of extra IAM policy ARNs to attach to the bastion role | list | `<list>` | no |
| extra_sg_ids | List of extra security group IDs for the bastion instance | list | `<list>` | no |
| extra_user_data | Any extra user-data. Will be appended to existing | string | `` | no |
| instance_ami_id | AMI ID for bastion instance. If not specified, see instance_ami_default | string | `` | no |
| instance_ami_name_filter | The name filter to use for getting an AMI ID for the region | string | `ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*` | no |
| instance_ami_owner_id_filter | The owner ID filter to use for getting an AMI ID for the region | string | `099720109477` | no |
| instance_key_name | Name of the SSH key in EC2 to use for instance | string | - | yes |
| instance_type | EC2 instance type | string | `t2.micro` | no |
| instance_volume_size | Instance EBS volume size | string | `32` | no |
| name | A unique name to identify this bastion and related resources | string | - | yes |
| public_subnet_ids | List of public subnets | list | - | yes |
| resource_name_prefix | A prefix to prepend to names of resources | string | `` | no |
| resource_name_suffix | A suffix to append to names of resources | string | `-bastion` | no |
| route53_record_prefix | Will be prefixed to the route53 record. Only used if route53_zone_id is passed also | string | `` | no |
| route53_record_suffix | Will be appended to the route53 record. Only used if route53_zone_id is passed also | string | `` | no |
| route53_record_ttl | TTL of route53 record. Only used if route53_zone_id is passed also | string | `60` | no |
| route53_zone_id | If specified a route53 record will be created | string | `` | no |
| tags | A map of tags to add to all resources. | map | `<map>` | no |
| vpc_id | The ID of the VPC where this bastion will exist | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| allow_ssh_from_bastion_sg_id | Put instances into this security group to allow SSH from the bastion |
| autoscaling_group_name | Name of the autoscaling group |
| bastion_aws_iam_role_arn | ARN of the bastion instance role |
| bastion_aws_iam_role_id | Name of the bastion inance role |
| bastion_sg_id | The security group of the bastion instance |
| eip | The elastic IP that is assigned to the bastion instance |
