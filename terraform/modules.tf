module aws_lambda_function {
  source = "./lambda/private_lambda_0"

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
  security_group_ids = [aws_security_group.private_lambda_0.id]
  subnet_ids         = [aws_subnet.private_0.id]
  random_string      = random_string.this
}

module aws_sqs_queue {
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