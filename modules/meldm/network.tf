module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.env
  cidr = "10.0.0.0/16"

  azs             = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = true
  enable_vpn_gateway = true

  manage_default_security_group = true
  default_security_group_ingress = [
        {
            from_port   = 80
            to_port     = 80
            protocol    = "tcp"
            cidr_blocks = "0.0.0.0/0"
        },
        {
            from_port   = 22
            to_port     = 22
            protocol    = "tcp"
            cidr_blocks = "0.0.0.0/0"
        },
  ]
  default_security_group_egress = [
        {
            from_port   = 0
            to_port     = 0
            protocol    = -1
            cidr_blocks = "0.0.0.0/0"
        }
  ]


}