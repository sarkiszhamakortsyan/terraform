provider "aws" {
  region = var.aws_region
}

terraform {
    backend "s3" {
        bucket = "terraform-state-sako-jenkins"
        region = "us-east-1"
        encrypt = false
    }
}

resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    name = "jenkins-instance-main_vpc"
  }
}