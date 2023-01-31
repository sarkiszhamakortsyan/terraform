terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = ">= 3.24"
    }
  }
}

provider "aws" {
  region = var.aws_region[terraform.workspace]
}

data "archive_file" "zip" {
  type = "zip"
  source_file = "main.py"
  output_path = "main.zip"
}

resource "aws_lambda_function" "python_lambda" {
  filename = "main.zip"
  function_name = "python_lambda_test_${terraform.workspace}"
  role = aws_iam_role.python_lambda_role.arn
  handler = "main.lambda_handler"
  runtime = "python3.8"
  source_code_hash = "data.archive_file.zip.output_base64sha256"
}

resource "aws_iam_role" "python_lambda_role" {
  name = "python_lambda_role_${terraform.workspace}"

  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
  }
  EOF
}

resource "aws_iam_role_policy_attachment" "sqs_access" {
  role = "${aws_iam_role.python_lambda_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
}

output "role" {
  value = aws_iam_role.python_lambda_role.arn
}

resource "aws_sqs_queue" "main_queue" {
  name = "main_queue_${terraform.workspace}"
  delay_seconds = 30
  max_message_size = 262144
}

resource "aws_sqs_queue" "dlq_queue" {
  name = "dlq-queue_${terraform.workspace}"
  delay_seconds = 30
  max_message_size = 262144
}

resource "aws_lambda_event_source_mapping" "sqs-lambda-trigger" {
  event_source_arn = aws_sqs_queue.main_queue.arn
  enabled = true
  function_name = aws_lambda_function.python_lambda.arn
}