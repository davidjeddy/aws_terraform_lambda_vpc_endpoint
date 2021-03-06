## data

data archive_file this {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "${path.module}/file.zip"
}

## resources

resource aws_lambda_function this {
  filename         = data.archive_file.this.output_path
  function_name    = join("-", [var.stage, var.name, "public-lambda", var.random_string.id])
  handler          = "index.lambda_handler"
  role             = aws_iam_role.this.arn
  runtime          = "python3.7"
  source_code_hash = data.archive_file.this.output_base64sha256

  tags = merge(
    {
      Name = join(var.delimiter, [var.name, var.stage, "public-lambda", var.random_string.id])
      Tech = "Python_3_7"
      Srv  = "Lambda"
    },
    var.tags
  )
}

## IAM role, policies, and attachments

resource aws_iam_policy this {
  name   = join(var.delimiter, [var.name, var.stage, "public-lambda-policy", var.random_string.id])
  path   = "/"
  policy = file("${path.module}/iam/policy.json")
}

resource aws_iam_role this {
  assume_role_policy = file("${path.module}/iam/role.json")
  name               = join(var.delimiter, [var.name, var.stage, "public-lambda-role", var.random_string.id])
}

resource aws_iam_role_policy_attachment this {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}

## Subscription to SQS queue

resource "aws_lambda_event_source_mapping" "example" {
  event_source_arn = var.aws_sqs_queue.arn
  function_name    = aws_lambda_function.this.arn
}
