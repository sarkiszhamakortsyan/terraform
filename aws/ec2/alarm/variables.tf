variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "region" {
  default = "us-east-1"
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "instance_tags" {
  type    = map
  default = {
    "environment" = "DEV"
  }
}

// Output variable

output "instance-ip" {
  value = module.ec2_cluster.public_ip
}

//output "instance-ip" {
//  value = aws_instance.linux_instance.public_ip
//}