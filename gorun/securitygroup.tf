provider "aws" {
  region = "ap-southeast-1"
}

module "vpc" {
  source      = "devops4mecode/vpc/aws"
  version     = "1.3.0"
  name        = "vpc"
  application = "devops4me"
  environment = "test"
  label_order = ["environment", "application", "name"]
  cidr_block  = "10.0.0.0/16"
}

module "security_group" {
  source = "./../"

  name          = "security-group"
  application   = "devops4me"
  environment   = "test"
  label_order   = ["environment", "application", "name"]
  vpc_id        = module.vpc.vpc_id
  protocol      = "tcp"
  description   = "Instance default security group (only egress access is allowed)."
  allowed_ip    = ["172.16.0.0/16", "10.0.0.0/16"]
  allowed_ipv6  = ["2405:201:5e00:3684:cd17:9397:5734:a167/128"]
  allowed_ports = [22, 27017]
}
