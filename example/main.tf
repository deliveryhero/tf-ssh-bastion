terraform {
  required_version = ">= 0.11.7"
}

provider "aws" {
  region = "us-east-1"
}

module "bastion1" {
  source            = "../"
  name              = "staging"
  vpc_id            = "${module.vpc1.vpc_id}"
  public_subnet_ids = ["${module.vpc1.public_subnets}"]

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
    },
  ]
}

module "vpc1" {
  source = "git@github.com:terraform-aws-modules/terraform-aws-vpc.git?ref=v1.37.0"
  name   = "us01-stg"
  cidr   = "10.0.0.0/16"
  azs    = ["us-east-1a", "us-east-1b", "us-east-1c"]

  private_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/25",
  ]

  public_subnets = [
    "10.0.4.0/24",
    "10.0.5.0/24",
    "10.0.6.0/25",
  ]
}
