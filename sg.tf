resource "aws_security_group" "this" {
  count       = length(var.access_list) > 0 ? 1 : 0
  name_prefix = var.domain_name
  vpc_id      = data.aws_subnet.selected[0].vpc_id
}

resource "aws_security_group_rule" "cluster" {
  count = length(var.access_list) > 0 ? 1 : 0

  # Required
  security_group_id = aws_security_group.this[0].id
  protocol          = "TCP"
  from_port         = 443
  to_port           = 443
  type              = "ingress"
  cidr_blocks       = var.access_list
}
