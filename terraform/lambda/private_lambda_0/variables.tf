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

variable random_string {
  description = "Random identifier string object."
  type = object({
    id = string
  })
}

## Module specific - Becuase the lambda is INSIDE a VPC, in a subnet, and needs a SG

variable availability_zone {
  description = "Availability zones withing the region"
  type        = list(string)
}

variable region {
  description = "AWS region"
  type        = string
}

variable vpc_private_cidr {
  description = "VPC network CIDR range"
  type        = string
}

variable security_group_ids {
  description = "Security group ID for the lambda placed into the private subnet."
  type = list
}

variable subnet_ids {
  description = "VPC subnet ID for the lambda placed into the private subnet."
  type = list
}

variable aws_sqs_queue {
  description = "Target SQS queue"
  type = object({
    arn = string
    id = string
  })
}