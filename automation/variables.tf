variable "lambda_name" {
  description = "Value of the Lambda function"
  type        = string
  default     = "Website"
}

variable "lambda_handler" {
  description = "The source of the lambda handler function in the format <file_name>.<handler_func_name>"
  type        = string
  default     = "index.handler"
}

