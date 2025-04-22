resource "aws_ec2_tag" "cluster_tag_private_subnets" {
  for_each = toset(var.private_subnets)

  resource_id = each.value
  key         = "kubernetes.io/cluster/${local.name}-al2"
  value       = "shared"
}

# 2nd tag: kubernetes.io/role/internal-elb = 1
resource "aws_ec2_tag" "role_tag_private_subnets" {
  for_each = toset(var.private_subnets)

  resource_id = each.value
  key         = "kubernetes.io/role/internal-elb"
  value       = "1"
}