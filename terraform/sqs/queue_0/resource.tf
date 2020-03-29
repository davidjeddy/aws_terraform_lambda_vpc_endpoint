resource aws_sqs_queue dead_letter_queue {
  name = join(var.delimiter, [var.name, var.stage, "sqs-dead-letter", var.random_string.id])

  tags = merge(
    {
      Name = join(var.delimiter, [var.name, var.stage, "sqs-dead-letter", var.random_string.id])
      Tech = "SQS"
      Srv  = "SQS"
    },
    var.tags
  )
}

resource aws_sqs_queue this {
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  name                      = join(var.delimiter, [var.name, var.stage, "sqs", var.random_string.id])
  receive_wait_time_seconds = 10

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dead_letter_queue.arn
    maxReceiveCount     = 4
  })

  tags = merge(
    {
      Name = join(var.delimiter, [var.name, var.stage, "sqs", var.random_string.id])
      Tech = "SQS"
      Srv  = "SQS"
    },
    var.tags
  )
}
