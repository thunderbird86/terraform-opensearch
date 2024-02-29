resource "aws_route53_record" "opensearch_public" {
  count = var.dns_name != "" && var.public_zone_id != "" ? 1 : 0

  zone_id = var.public_zone_id
  name    = var.dns_name
  type    = "CNAME"
  ttl     = "60"

  records = [aws_opensearch_domain.this.endpoint]
}

resource "aws_route53_record" "opensearch_private" {
  count = var.dns_name != "" && var.private_zone_id != "" ? 1 : 0

  zone_id = var.private_zone_id
  name    = var.dns_name
  type    = "CNAME"
  ttl     = "60"

  records = [aws_opensearch_domain.this.endpoint]
}
