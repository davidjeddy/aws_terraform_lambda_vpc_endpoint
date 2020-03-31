# Networking

## Internet Gateway

resource aws_internet_gateway this {
  vpc_id = aws_vpc.this.id

  depends_on = [
    aws_vpc.this
  ]

  tags = merge(
    {
      Name = join(var.delimiter, [var.name, var.stage, "internet-gateway", random_string.this.result])
      Tech = "VPC"
      Srv  = "IGW"
    },
    var.tags
  )
}

## VPC

resource aws_vpc this {
  assign_generated_ipv6_cidr_block = false
  cidr_block                       = var.vpc_private_cidr
  enable_dns_hostnames             = true
  enable_dns_support               = true

  tags = merge(
    {
      Name = join(var.delimiter, [var.name, var.stage, "vpc", random_string.this.result])
      Tech = "VPC"
      Srv  = "VPC"
    },
    var.tags
  )
}

## Route Table <-> Subnet assocations

resource aws_route_table_association private_0 {
  subnet_id      = aws_subnet.private_0.id
  route_table_id = aws_route_table.private_0.id
}

## Route Tables

resource aws_route_table private_0 {
  vpc_id = aws_vpc.this.id

  depends_on = [
    aws_vpc.this
  ]

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(
    {
      Name = join(var.delimiter, [var.name, var.stage, "private-route", random_string.this.result])
      Tech = "Route"
      Srv  = "VPC"
    },
    var.tags
  )
}

## Subnets

resource aws_subnet private_0 {
  availability_zone               = var.availability_zone[0]
  vpc_id                          = aws_vpc.this.id
  cidr_block                      = var.vpc_private_cidr
  assign_ipv6_address_on_creation = false

  depends_on = [
    aws_vpc.this
  ]

  tags = merge(
    {
      Name = join(var.delimiter, [var.name, var.stage, "subnet-a", random_string.this.result])
      Tech = "Subnet"
      Srv  = "VPC"
      Note = "Private"
    },
    var.tags
  )
}
