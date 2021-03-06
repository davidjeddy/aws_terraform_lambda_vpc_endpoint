module private_lambda_0 {
  source = "./lambda/private_lambda_0"

  # generic vars
  aws_acct_id       = var.aws_acct_id
  delimiter         = var.delimiter
  name              = var.name
  owner             = var.owner
  random_string      = random_string.this
  region            = var.region
  stage             = var.stage
  tags              = var.tags

  # module vars
  availability_zone  = var.availability_zone
  aws_sqs_queue      = module.aws_sqs_queue_0.aws_sqs_queue
  security_group_ids = [aws_security_group.private_lambda_0.id]
  subnet_ids         = [aws_subnet.private_0.id]
  vpc_private_cidr   = var.vpc_private_cidr
}

module aws_sqs_queue_0 {
  source = "./sqs/queue_0"

  # generic vars
  aws_acct_id       = var.aws_acct_id
  name              = var.name
  stage             = var.stage
  delimiter         = var.delimiter
  owner             = var.owner
  tags              = var.tags
  availability_zone = var.availability_zone
  region            = var.region
  vpc_private_cidr  = var.vpc_private_cidr

  # module vars
  random_string      = random_string.this
}

module public_lambda_0 {
  source = "./lambda/public_lambda_0"

  # generic vars
  aws_acct_id       = var.aws_acct_id
  delimiter         = var.delimiter
  name              = var.name
  owner             = var.owner
  random_string     = random_string.this
  stage             = var.stage
  tags              = var.tags

  # module vars
  aws_sqs_queue      = module.aws_sqs_queue_0.aws_sqs_queue
}
