data "aws_subnet" "selected" {
  count = length(var.subnet_ids) > 0 ? 1 : 0
  id = var.subnet_ids[0]
}

data "aws_route53_zone" "public" {
  count = var.public_zone_id != "" ? 1 : 0
  zone_id = var.public_zone_id
}

data "aws_route53_zone" "private" {
  count = var.private_zone_id != "" ? 1 : 0
  zone_id = var.private_zone_id
}
