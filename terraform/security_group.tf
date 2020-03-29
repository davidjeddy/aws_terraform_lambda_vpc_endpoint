resource aws_security_group private_lambda {
  description = "Private Lambda SG"
  name        = join(var.delimiter, [var.name, var.stage, "private-subnet-lambda", random_string.this.id])
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # AKA allow everywhere inbound
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/28"] # AKA allow private subnet outbound
  }

  tags = merge(
    {
      Name = join(var.delimiter, [var.name, var.stage, "private-subnet-lambda", random_string.this.id])
      Tech = "Security Group"
      Srv  = "EC2"
    },
    var.tags
  )
}
