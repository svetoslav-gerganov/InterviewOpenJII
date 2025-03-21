resource "aws_vpc" "app_vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name = "${var.app_name}-vpc-${var.environment}"
  }
}

resource "aws_subnet" "app_subnets" {
  count                    = 2
  vpc_id                   = aws_vpc.app_vpc.id
  cidr_block               = "10.0.${count.index + 1}.0/24"
  availability_zone        = "${var.aws_region}${count.index == 0 ? "a" : "b"}"
  map_public_ip_on_launch  = true
  tags = {
    Name = "${var.app_name}-subnet-${var.environment}-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "app_igw" {
  vpc_id = aws_vpc.app_vpc.id
  tags = {
    Name = "${var.app_name}-igw-${var.environment}"
  }
}

resource "aws_route_table" "app_route_table" {
  vpc_id = aws_vpc.app_vpc.id
  tags = {
    Name = "${var.app_name}-route-table-${var.environment}"
  }
}

resource "aws_route" "app_route" {
  route_table_id         = aws_route_table.app_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.app_igw.id
}

resource "aws_route_table_association" "app_subnet_associations" {
  count          = length(aws_subnet.app_subnets)
  route_table_id = aws_route_table.app_route_table.id
  subnet_id      = aws_subnet.app_subnets[count.index].id
}