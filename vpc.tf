resource "aws_vpc" "my-vpc" {
  cidr_block           = "10.0.0.0/24"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "My VPC"
  }
}

resource "aws_subnet" "my_public_subnet_1" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.0.0/25"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "My Public Subnet 1"
  }
}

resource "aws_subnet" "my_public_subnet_2" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.0.128/25"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "My Public Subnet 2"
  }
}

resource "aws_internet_gateway" "my_internet_gateway" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "My Internet Gateway"
  }
}

resource "aws_route_table" "my_public_route_table" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "My Public Route Table"
  }
}

resource "aws_route_table_association" "my_public_subnet_1_route_association" {
  subnet_id      = aws_subnet.my_public_subnet_1.id
  route_table_id = aws_route_table.my_public_route_table.id
}

resource "aws_route_table_association" "my_public_subnet_2_route_association" {
  subnet_id      = aws_subnet.my_public_subnet_2.id
  route_table_id = aws_route_table.my_public_route_table.id
}

resource "aws_route" "my_public_route_gateway_association" {
  route_table_id         = aws_route_table.my_public_route_table.id
  gateway_id             = aws_internet_gateway.my_internet_gateway.id
  destination_cidr_block = "0.0.0.0/0"
}
