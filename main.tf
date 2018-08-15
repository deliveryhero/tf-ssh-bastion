/**
# SSH bastion

Creates an autoscaling group, security groups, IAM policy, elastic IP and user-data to automatically assign the elastic IP. This ensures an SSH bastion is always present with the same public IP address.

### Example

* ```hcl
* module "bastion1" {
*   source                  = "git@github.com:deliveryhero/tf-ssh-bastion.git?ref=0.2"
*   name                    = "staging"
*   vpc_id                  = "vpc123456"
*   instance_key_name       = "my-ec2-key"
*   route53_zone_id         = "EXAMPLE12345"
*   public_subnet_ids       = ["${module.vpc1.public_subnets}"]
*
*   allowed_ssh_cidr_blocks = [
*     "203.1.2.3/32",
*     "203.4.5.6/32",
*   ]
*
*   tags = {
*     terraform   = "true"
*     environment = "staging"
*   }
* }
* ```

### Example with users

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
