resource "aws_ec2_tag" "private_subnet_tags" {
  for_each = toset(var.private_subnets)

  resource_id = each.value

  tags = {
    "kubernetes.io/cluster/${local.name}-al2" = "shared"
    "kubernetes.io/role/internal-elb"         = "1"
  }
}