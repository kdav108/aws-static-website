terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-southeast-2"
}

data "archive_file" "lambda_code" {
  type = "zip"

  source_dir  = "${path.module}/../lambda_code"
  output_path = "${path.module}/../build/lambda_code.zip"
}

resource "aws_lambda_function" "lambda_website" {
  function_name = var.lambda_name

  runtime = "nodejs14.x"
  handler = var.lambda_handler

  filename = data.archive_file.lambda_code.output_path

  role = aws_iam_role.basic_lambda_exec.arn
}

resource "aws_lambda_function_url" "lambda_website_url" {
  function_name      = aws_lambda_function.lambda_website.function_name
  authorization_type = "NONE"
}

resource "aws_iam_role" "basic_lambda_exec" {
  name = "lambda_website"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.basic_lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}