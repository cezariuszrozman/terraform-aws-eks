resource "aws_subnet" "private_subnets_tagged" {
  for_each = toset(var.private_subnets)
  vpc_id = var.vpc_id
  subnet_id = each.key


  tags = {
    "Name"                                    = "eks-private-subnet-${each.key}"
    "kubernetes.io/cluster/${local.name}-al2" = "shared"
    "kubernetes.io/role/internal-elb"         = "1"
  }
}