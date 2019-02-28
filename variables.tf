variable "name" {
  type        = "string"
  description = "A unique name to identify this bastion and related resources"
}

variable "resource_name_suffix" {
  type        = "string"
  default     = "-bastion"
  description = "A suffix to append to names of resources"
}

variable "vpc_id" {
  type        = "string"
  description = "The ID of the VPC where this bastion will exist"
}

variable "instance_key_name" {
  type        = "string"
  description = "Name of the SSH key in EC2 to use for instance"
  default     = ""
}

variable "instance_ami_id" {
  type        = "string"
  default     = ""
  description = "AMI ID for bastion instance. If not specified, see instance_ami_default"
}

variable "instance_ami_name_filter" {
  type        = "string"
  description = "The name filter to use for getting an AMI ID for the region"
  default     = "ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"
}

variable "instance_ami_owner_id_filter" {
  type        = "list"
  description = "The owner IDs to use for getting an AMI ID for the region"
  default     = ["099720109477"]
}

variable "allowed_ssh_cidr_blocks" {
  type        = "list"
  description = "CIDR blocks to allow SSH from. Should be set to your trusted IP or IP ranges"

  default = [
    "0.0.0.0/0",
  ]
}

variable "public_subnet_ids" {
  type        = "list"
  description = "List of public subnets"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
  type        = "string"
}

variable "extra_user_data" {
  description = "Any extra user-data. Will be appended to existing"
  type        = "string"
  default     = ""
}

variable "instance_volume_size" {
  description = "Instance EBS volume size"
  default     = "32"
  type        = "string"
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = "map"
  default     = {}
}

variable "extra_iam_policy_arns" {
  type        = "list"
  description = "List of extra IAM policy ARNs to attach to the bastion role"
  default     = []
}

variable "extra_sg_ids" {
  type        = "list"
  description = "List of extra security group IDs for the bastion instance"
  default     = []
}

variable "route53_zone_id" {
  type        = "string"
  default     = ""
  description = "If specified a route53 record will be created"
}

variable "route53_record_ttl" {
  type        = "string"
  default     = 60
  description = "TTL of route53 record. Only used if route53_zone_id is passed also"
}

variable "route53_record_name" {
  type        = "string"
  default     = ""
  description = "Name of the route53 record. Only used if route53_zone_id is passed. If not set then `name` variable is used"
}

variable "users" {
  description = "A list of maps of extra users containing usernames, keys and groups. See README for example"
  type        = "list"
  default     = []
}
