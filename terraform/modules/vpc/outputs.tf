output "vpc_id" {
  value = aws_vpc.app_vpc.id
}

output "subnets" {
  value = aws_subnet.app_subnets[*].id
}