resource aws_security_group private_lambda_0 {
  description = "Private Lambda SG"
  name        = join(var.delimiter, [var.name, var.stage, "private-subnet-lambda-0", random_string.this.id])
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [
      "0.0.0.0/0", # AKA allow everywhere inbound
      var.vpc_private_cidr
    ]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [
      "0.0.0.0/0", # AKA allow everywhere inbound
      var.vpc_private_cidr
    ]
  }

  tags = merge(
    {
      Name = join(var.delimiter, [var.name, var.stage, "private-subnet-lambda-0", random_string.this.id])
      Tech = "Security Group"
      Srv  = "EC2"
    },
    var.tags
  )
}
