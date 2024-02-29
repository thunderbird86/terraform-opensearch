# AWS OpenSearch Terraform module

Terraform module which creates AWS OpenSearch (ElasticSearch) resources

## Available Features

- AWS OpenSearch Cluster


## Usage

```hcl
module "infra_elasticsearch" {
  source = ""

  domain_name = var.domain_name

  subnet_ids = data.terraform_remote_state.network.outputs.private_subnets

  vpc_id                          = data.terraform_remote_state.network.outputs.vpc_id
  access_policies                 = data.template_file.access_policies.rendered
  security_group_ids              = [data.terraform_remote_state.network.outputs.default_security_group_id]
  enforce_https                   = true
  dns_name                        = "logs"
  custom_endpoint_certificate_arn = "arn:aws:acm:us-east-1:773267254890:certificate/cadcb88c-2a54-47bb-bd5d-25c32e8822ff"

  internal_user_database_enabled = true
  anonymous_auth_enabled         = false

  saml_enabled     = true
  metadata_content = data.template_file.metadata.rendered
  entity_id        = "http://www.okta.com/exk82uobuxEe5lBxx5d7"

  tags = {
    Environment = var.env_name
    Purpouse    = "infra-logs"
  }
}
```

## Development
- `make init`: initialize terraform and tflint
- `make validate`: validate terraform code
- `make fmt`: check terraform code formatting (rewrites code by default)
- `make lint`: terraform code linting with tflint and tfsec
- `make docs`: docs generation

## Links
- [Local development environment](https://github.com/workato-devops/tf-module-skeleton#local-development-environment)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.1.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | = 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.5.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_service_linked_role.opensearchservice](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_service_linked_role) | resource |
| [aws_opensearch_domain.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/opensearch_domain) | resource |
| [aws_opensearch_domain_saml_options.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/opensearch_domain_saml_options) | resource |
| [aws_route53_record.opensearch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_subnet.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_list"></a> [access\_list](#input\_access\_list) | List of CIDR which be allowed access to OpenSearch domain | `list(string)` | <pre>[<br>  "10.0.0.0/8"<br>]</pre> | no |
| <a name="input_access_policies"></a> [access\_policies](#input\_access\_policies) | IAM policy document specifying the access policies for the domain | `string` | `""` | no |
| <a name="input_advanced_options"></a> [advanced\_options](#input\_advanced\_options) | Key-value string pairs to specify advanced configuration options. | `map(any)` | <pre>{<br>  "override_main_response_version": "true"<br>}</pre> | no |
| <a name="input_advanced_security_options"></a> [advanced\_security\_options](#input\_advanced\_security\_options) | Whether enable configuration block for fine-grained access control | `bool` | `true` | no |
| <a name="input_anonymous_auth_enabled"></a> [anonymous\_auth\_enabled](#input\_anonymous\_auth\_enabled) | Whether Anonymous auth is enabled | `bool` | `false` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Whether zone awareness is enabled | `number` | `3` | no |
| <a name="input_custom_endpoint_certificate_arn"></a> [custom\_endpoint\_certificate\_arn](#input\_custom\_endpoint\_certificate\_arn) | ACM certificate ARN for your custom endpoint | `string` | `""` | no |
| <a name="input_custom_endpoint_enabled"></a> [custom\_endpoint\_enabled](#input\_custom\_endpoint\_enabled) | Whether to enable custom endpoint for the OpenSearch domain | `bool` | `true` | no |
| <a name="input_dedicated_master_count"></a> [dedicated\_master\_count](#input\_dedicated\_master\_count) | Number of dedicated main nodes in the cluster | `number` | `3` | no |
| <a name="input_dedicated_master_enabled"></a> [dedicated\_master\_enabled](#input\_dedicated\_master\_enabled) | Whether dedicated main nodes are enabled for the cluster | `bool` | `true` | no |
| <a name="input_dedicated_master_type"></a> [dedicated\_master\_type](#input\_dedicated\_master\_type) | Instance type of the dedicated main nodes in the cluster | `string` | `"c6g.large.search"` | no |
| <a name="input_desired_state"></a> [desired\_state](#input\_desired\_state) | Auto-Tune desired state for the domain | `string` | `"ENABLED"` | no |
| <a name="input_dns_name"></a> [dns\_name](#input\_dns\_name) | The name of the DNS record | `string` | `""` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Name of the domain | `string` | n/a | yes |
| <a name="input_ebs_enabled"></a> [ebs\_enabled](#input\_ebs\_enabled) | Whether EBS volumes are attached to data nodes in the domain | `bool` | `true` | no |
| <a name="input_enable_encrypt_at_rest"></a> [enable\_encrypt\_at\_rest](#input\_enable\_encrypt\_at\_rest) | Whether to enable encryption at rest | `bool` | `true` | no |
| <a name="input_encrypt_kms_key_id"></a> [encrypt\_kms\_key\_id](#input\_encrypt\_kms\_key\_id) | KMS key ARN to encrypt the Elasticsearch domain with | `string` | `""` | no |
| <a name="input_enforce_https"></a> [enforce\_https](#input\_enforce\_https) | Whether or not to require HTTPS | `bool` | `true` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | Version of OpenSearch to deploy | `string` | `"OpenSearch_2.3"` | no |
| <a name="input_entity_id"></a> [entity\_id](#input\_entity\_id) | The unique Entity ID of the application in SAML Identity Provider | `string` | `""` | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | Number of instances in the cluster | `number` | `3` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type of data nodes in the cluster | `string` | `"m6g.large.search"` | no |
| <a name="input_internal_user_database_enabled"></a> [internal\_user\_database\_enabled](#input\_internal\_user\_database\_enabled) | Whether the internal user database is enabled | `bool` | `false` | no |
| <a name="input_iops"></a> [iops](#input\_iops) | Baseline input/output (I/O) performance of EBS volumes attached to data nodes | `number` | `3000` | no |
| <a name="input_master_user_name"></a> [master\_user\_name](#input\_master\_user\_name) | Main user's username | `string` | `""` | no |
| <a name="input_master_user_password"></a> [master\_user\_password](#input\_master\_user\_password) | Main user's password | `string` | `""` | no |
| <a name="input_metadata_content"></a> [metadata\_content](#input\_metadata\_content) | The Metadata of the SAML application in xml format | `string` | `""` | no |
| <a name="input_node_to_node_encryption"></a> [node\_to\_node\_encryption](#input\_node\_to\_node\_encryption) | Whether to enable node-to-node encryption | `bool` | `true` | no |
| <a name="input_rollback_on_disable"></a> [rollback\_on\_disable](#input\_rollback\_on\_disable) | Whether to roll back to default Auto-Tune settings when disabling Auto-Tune | `string` | `"NO_ROLLBACK"` | no |
| <a name="input_saml_enabled"></a> [saml\_enabled](#input\_saml\_enabled) | Whether SAML authentication is enabled | `bool` | `true` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | List of VPC Security Group IDs to be applied to the OpenSearch domain endpoints | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of VPC Subnet IDs for the OpenSearch domain endpoints to be created in | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to assign to the resource | `map(any)` | `{}` | no |
| <a name="input_throughput"></a> [throughput](#input\_throughput) | Specifies the throughput (in MiB/s) | `number` | `250` | no |
| <a name="input_tls_security_policy"></a> [tls\_security\_policy](#input\_tls\_security\_policy) | Name of the TLS security policy that needs to be applied to the HTTPS endpoint | `string` | `"Policy-Min-TLS-1-2-2019-07"` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | Size of EBS volumes attached to data nodes (in GiB) | `number` | `1024` | no |
| <a name="input_volume_type"></a> [volume\_type](#input\_volume\_type) | Type of EBS volumes attached to data nodes | `string` | `"gp3"` | no |
| <a name="input_warm_count"></a> [warm\_count](#input\_warm\_count) | Number of warm nodes in the cluster | `number` | `0` | no |
| <a name="input_warm_enabled"></a> [warm\_enabled](#input\_warm\_enabled) | Whether to enable warm storage | `bool` | `false` | no |
| <a name="input_warm_type"></a> [warm\_type](#input\_warm\_type) | Instance type for the Elasticsearch cluster's warm nodes | `string` | `"ultrawarm1.medium.elasticsearch"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | The ID of the hosted zone to contain this record | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the domain |
| <a name="output_domain_id"></a> [domain\_id](#output\_domain\_id) | Unique identifier for the domain |
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | Name of the OpenSearch domain |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | Domain-specific endpoint used to submit index, search, and data upload requests |
| <a name="output_kibana_endpoint"></a> [kibana\_endpoint](#output\_kibana\_endpoint) | Domain-specific endpoint for kibana without https scheme |
<!-- END_TF_DOCS -->