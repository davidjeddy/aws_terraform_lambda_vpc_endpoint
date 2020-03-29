## Generic

variable aws_acct_id {
  default     = "0"
  description = "AWS account ID"
  type        = number
}

variable name {
  default     = "aws_terraform_vpc_endpoint"
  description = "Application name"
  type        = string
}

variable stage {
  default     = "dev"
  description = "The stage; aka environment"
  type        = string
}

variable delimiter {
  default     = "-"
  description = "Delimiter to use between human words"
  type        = string
}

variable owner {
  default     = "me@davidjeddy.com"
  description = "Owner email"
  type        = string
}

variable tags {
  default = {
    Contact = "me@davidjeddy.com",
    Stage   = "dev",
    Owner   = "dje"
  }
  description = "Default shared tags"
  type        = map
}

## VPC

variable availability_zone {
  default     = [
    "us-west-2a",
    "us-west-2b",
  ]
  description = "Availability zones withing the region"
  type        = list(string)
}

variable region {
  default     = "us-west-2"
  description = "AWS region"
  type        = string
}

variable vpc_private_cidr {
  default     = "10.0.0.0/24"
  description = "VPC network CIDR range"
  type        = string
}
