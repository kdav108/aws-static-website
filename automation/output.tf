output "lambda_func_name" {
  value = aws_lambda_function.lambda_website.function_name
}

output "website_URL" {
  value = aws_lambda_function_url.lambda_website_url.function_url
}