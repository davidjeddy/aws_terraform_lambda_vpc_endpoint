## Generic

variable aws_acct_id {
  description = "AWS account ID"
  type        = number
}

variable name {
  description = "Application name"
  type        = string
}

variable stage {
  description = "The stage; aka environment"
  type        = string
}

variable delimiter {
  description = "Delimiter to use between human words"
  type        = string
}

variable owner {
  description = "Owner email"
  type        = string
}

variable tags {
  description = "Default shared tags"
  type        = map
}

## Module specific

variable aws_sqs_queue {
  description = "Target SQS queue"
  type = object({
    arn = string
    id = string
  })
}

variable random_string {
  description = "Random identifier string object."
  type = object({
    id = string
  })
}