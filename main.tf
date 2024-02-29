locals {
  zone_name = var.public_zone_id != "" ? data.aws_route53_zone.public[0].name : data.aws_route53_zone.private[0].name
}

resource "aws_iam_service_linked_role" "opensearchservice" {
  count            = var.create_linked_role == true ? 1 : 0
  aws_service_name = "opensearchservice.amazonaws.com"
}

resource "aws_opensearch_domain" "this" {
  domain_name    = var.domain_name
  engine_version = var.engine_version

  advanced_security_options {
    enabled                        = var.advanced_security_options
    anonymous_auth_enabled         = var.anonymous_auth_enabled
    internal_user_database_enabled = var.internal_user_database_enabled
    master_user_options {
      master_user_name     = var.master_user_name
      master_user_password = var.master_user_password
    }
  }

  access_policies  = var.access_policies
  advanced_options = var.advanced_options

  cluster_config {
    dedicated_master_enabled = var.dedicated_master_enabled
    dedicated_master_count   = var.dedicated_master_enabled ? var.dedicated_master_count : null
    dedicated_master_type    = var.dedicated_master_enabled ? var.dedicated_master_type : null

    instance_count = var.instance_count
    instance_type  = var.instance_type

    warm_enabled = var.warm_enabled
    warm_count   = var.warm_enabled ? var.warm_count : null
    warm_type    = var.warm_enabled ? var.warm_type : null

    zone_awareness_enabled = (var.availability_zones > 1) ? true : false

    dynamic "zone_awareness_config" {
      for_each = (var.availability_zones > 1) ? [var.availability_zones] : []
      content {
        availability_zone_count = zone_awareness_config.value
      }
    }
  }

  domain_endpoint_options {
    enforce_https       = var.enforce_https
    tls_security_policy = var.tls_security_policy

    custom_endpoint_enabled         = var.custom_endpoint_enabled
    custom_endpoint                 = format("%s.%s", var.dns_name, local.zone_name)
    custom_endpoint_certificate_arn = var.custom_endpoint_certificate_arn
  }

  node_to_node_encryption {
    enabled = var.node_to_node_encryption
  }

  encrypt_at_rest {
    enabled    = var.enable_encrypt_at_rest
    kms_key_id = var.encrypt_kms_key_id
  }

  ebs_options {
    ebs_enabled = var.ebs_enabled
    volume_type = var.ebs_enabled ? var.volume_type : null
    volume_size = var.ebs_enabled ? var.volume_size : null

    iops       = var.ebs_enabled ? var.iops : null
    throughput = var.ebs_enabled ? var.throughput : null
  }

  dynamic "auto_tune_options" {
    for_each = var.autotune == "ENABLED" ? [1] : []

    content {
      desired_state       = var.os_autotune
      rollback_on_disable = "NO_ROLLBACK"
    }
  }

  dynamic "vpc_options" {
    for_each = (length(var.subnet_ids) > 0) ? [var.subnet_ids] : []
    content {
      subnet_ids         = var.subnet_ids
      security_group_ids = concat([aws_security_group.this[0].id], var.security_group_ids)
    }
  }

  tags = merge(
    var.tags,
    { "Name" = var.domain_name },
  )

  depends_on = [aws_iam_service_linked_role.opensearchservice]
}

resource "aws_opensearch_domain_saml_options" "this" {
  count       = var.saml_enabled ? 1 : 0
  domain_name = aws_opensearch_domain.this.domain_name

  saml_options {
    enabled = var.saml_enabled
    idp {
      entity_id        = var.entity_id
      metadata_content = var.metadata_content
    }
  }
}
