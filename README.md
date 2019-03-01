# SSH bastion

This module creates a flexible and highly available SSH bastion with a fixed public IP address. This includes adding users, group, SSH keys and sudo config to give you a simple but complete SSH gateway into your AWS infrastructure without the need for a configuration management system. This module creates an autoscaling group, security groups, IAM policy, elastic IP and user-data to automatically assign the elastic IP and setup users and keys.

```hcl
module "bastion1" {
  source                  = "git@github.com:deliveryhero/tf-ssh-bastion.git?ref=0.2"
  name                    = "staging"
  vpc_id                  = "vpc123456"
  instance_key_name       = "my-ec2-key"
  public_subnet_ids       = ["${module.vpc1.public_subnets}"]

  allowed_ssh_cidr_blocks = [
    "203.1.2.3/32",
  ]

  users = [
    {
      username = "max"
      group    = "ubuntu"
      key      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDez8.."
    },
    {
      username = "phil"
      group    = "sudo"
      key      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDez8.."
    }
  ]
}
```

See [example](example) for a complete example with VPC.

## Documentation generation

Documentation should be modified within `main.tf` and generated using [terraform-docs](https://github.com/segmentio/terraform-docs):

```bash
terraform-docs --with-aggregate-type-defaults md ./ > README.md
```

## License

MIT Licensed. See [LICENSE](https://github.com/deliveryhero/tf-ssh-bastion/tree/master/LICENSE) for full details.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| allowed\_ssh\_cidr\_blocks | CIDR blocks to allow SSH from. Should be set to your trusted IP or IP ranges | list | `[ "0.0.0.0/0" ]` | no |
| extra\_iam\_policy\_arns | List of extra IAM policy ARNs to attach to the bastion role | list | `[]` | no |
| extra\_sg\_ids | List of extra security group IDs for the bastion instance | list | `[]` | no |
| extra\_user\_data | Any extra user-data. Will be appended to existing | string | `` | no |
| instance\_ami\_id | AMI ID for bastion instance. If not specified, see instance_ami_default | string | `` | no |
| instance\_ami\_name\_filter | The name filter to use for getting an AMI ID for the region | string | `ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*` | no |
| instance\_ami\_owner\_id\_filter | The ID filter accepts `self` or owner's ID or alias of an AMI | list | `[099720109477]` | no |
| instance\_key\_name | Name of the SSH key in EC2 to use for instance | string | `` | no |
| instance\_type | EC2 instance type | string | `t2.micro` | no |
| instance\_volume\_size | Instance EBS volume size | string | `32` | no |
| name | A unique name to identify this bastion and related resources | string | - | yes |
| public\_subnet\_ids | List of public subnets | list | - | yes |
| resource\_name\_suffix | A suffix to append to names of resources | string | `-bastion` | no |
| route53\_record\_name | Name of the route53 record. Only used if route53_zone_id is passed. If not set then `name` variable is used | string | `` | no |
| route53\_record\_ttl | TTL of route53 record. Only used if route53_zone_id is passed also | string | `60` | no |
| route53\_zone\_id | If specified a route53 record will be created | string | `` | no |
| tags | A map of tags to add to all resources. | map | `{}` | no |
| users | A list of maps of extra users containing usernames, keys and groups. See README for example | list | `[]` | no |
| vpc\_id | The ID of the VPC where this bastion will exist | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| allow\_ssh\_from\_bastion\_sg\_id | Put instances into this security group to allow SSH from the bastion |
| autoscaling\_group\_name | Name of the autoscaling group |
| aws\_iam\_role\_id | Name of the bastion inance role |
| eip | The elastic IP that is assigned to the bastion instance |
| role\_arn | ARN of the bastion instance role |
| sg\_id | The security group of the bastion instance |
| user\_data\_full | The complete user-data from the bastion instance |
| user\_data\_users | The useradd and SSH key setup part of the user-data from the bastion instance |
