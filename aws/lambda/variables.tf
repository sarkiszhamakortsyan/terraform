variable "aws_region" {
  type = map
  default = {
    dev = "us-east-1"
    prod = "us-east-2"
  } 
}