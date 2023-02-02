# # # # # # # # # # # # # # # # #
# PROVIDER
# # # # # # # # # # # # # # # # #

provider "aws" {
  region = var.aws_region
}

# # # # # # # # # # # # # # # # #
# TERRAFORM USER
# # # # # # # # # # # # # # # # #

data "aws_iam_user" "terraform" {
  user_name = "terraform"
}

terraform {
    backend "s3" {
        bucket = "terraform-state-sako-jenkins"
        region = "us-east-1"
        encrypt = false
    }
}
