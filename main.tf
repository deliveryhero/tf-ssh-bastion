/**
# SSH bastion

This module creates a flexible and highly available SSH bastion with a fixed public IP address. This includes adding users, group, SSH keys and sudo config to give you a simple but complete SSH gateway into your AWS infrastructure without the need for a configuration management system. This module creates an autoscaling group, security groups, IAM policy, elastic IP and user-data to automatically assign the elastic IP and setup users and keys.

* ```hcl
* module "bastion1" {
*   source                  = "git@github.com:deliveryhero/tf-ssh-bastion.git?ref=0.2"
*   name                    = "staging"
*   vpc_id                  = "vpc123456"
*   instance_key_name       = "my-ec2-key"
*   public_subnet_ids       = ["${module.vpc1.public_subnets}"]
*
*   allowed_ssh_cidr_blocks = [
*     "203.1.2.3/32",
*   ]
*
*   users = [
*     {
*       username = "max"
*       group    = "ubuntu"
*       key      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDez8.."
*     },
*     {
*       username = "phil"
*       group    = "sudo"
*       key      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDez8.."
*     }
*   ]
* }
* ```

See [example](example) for a complete example with VPC.

## Documentation generation

Documentation should be modified within `main.tf` and generated using [terraform-docs](https://github.com/segmentio/terraform-docs):

```bash
terraform-docs md ./ | cat -s | tail -r | tail -n +2 | tail -r > README.md
```

## License

MIT Licensed. See [LICENSE](https://github.com/deliveryhero/tf-ssh-bastion/tree/master/LICENSE) for full details.
*/

provider "null" {}
provider "template" {}
