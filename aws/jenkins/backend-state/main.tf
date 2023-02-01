provider "aws" {
  region = var.aws_region
  //access_key = var.aws_access_key
  //secret_key = var.aws_secret_key
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-sako-jenkins"
}

resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  lifecycle {
    prevent_destroy = false
  }

  versioning_configuration {
    status = "Enabled"
  }
}