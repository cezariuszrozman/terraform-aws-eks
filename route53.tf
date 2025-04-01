resource "aws_route53_zone" "primary" {
  name = "szkolenie.com"

  tags = merge(
    local.tags,
    {
      Name = "szkolenie.com"
    }
  )
}

# Output the name servers assigned to the zone
output "name_servers" {
  description = "Name servers for the example.com hosted zone"
  value       = aws_route53_zone.primary.name_servers
}