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

## VPC

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

## Module specific

variable random_string {
  description = "Random identifier string object."
  type = object({
    id = string
  })
}