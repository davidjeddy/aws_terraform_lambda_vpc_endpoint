# Hasicorp Providers
resource random_string this {
  length  = 4
  special = false
  upper   = false
}

resource aws_vpc_endpoint sqs {
  private_dns_enabled = true
  service_name        = join(".", ["com.amazonaws", var.region, "sqs"])
  vpc_endpoint_type   = "Interface"
  vpc_id              = aws_vpc.this.id

  security_group_ids = [
    aws_security_group.private_lambda_0.id
  ]

  # Interface types get this. It connects the Endpoint to a subnet
  subnet_ids = [
    aws_subnet.private_0.id
  ] 

  tags = merge(
    {
      Name = join(var.delimiter, [var.name, var.stage, "service-endpoint-for-sqs", random_string.this.id])
      Tech = "Service Endpoint"
      Srv  = "VPC"
    },
    var.tags
  )
}
