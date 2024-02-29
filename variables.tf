variable "domain_name" {
  description = "Name of the domain"
  type        = string
}

variable "subnet_ids" {
  description = "List of VPC Subnet IDs for the OpenSearch domain endpoints to be created in"
  type        = list(string)
  default     = []
}

variable "engine_version" {
  description = "Version of OpenSearch to deploy"
  type        = string
  default     = "OpenSearch_2.11"
}

variable "advanced_security_options" {
  description = "Whether enable configuration block for fine-grained access control"
  type        = bool
  default     = true
}

variable "security_group_ids" {
  description = "List of VPC Security Group IDs to be applied to the OpenSearch domain endpoints"
  type        = list(string)
  default     = [""]
}

variable "access_policies" {
  description = "IAM policy document specifying the access policies for the domain"
  type        = string
  default     = ""
}

variable "dedicated_master_enabled" {
  description = "Whether dedicated main nodes are enabled for the cluster"
  type        = bool
  default     = true
}

variable "dedicated_master_count" {
  description = "Number of dedicated main nodes in the cluster"
  type        = number
  default     = 3
}

variable "dedicated_master_type" {
  description = "Instance type of the dedicated main nodes in the cluster"
  type        = string
  default     = "c6g.large.search"
}

variable "instance_count" {
  description = "Number of instances in the cluster"
  type        = number
  default     = 3
}

variable "instance_type" {
  description = "Instance type of data nodes in the cluster"
  type        = string
  default     = "m6g.large.search"
}

variable "access_list" {
  description = "List of CIDR which be allowed access to OpenSearch domain"
  type        = list(string)
  default = [
    "10.0.0.0/8"
  ]
}

variable "warm_enabled" {
  description = "Whether to enable warm storage"
  type        = bool
  default     = false
}

variable "warm_count" {
  description = "Number of warm nodes in the cluster"
  type        = number
  default     = 0
}

variable "warm_type" {
  description = "Instance type for the Elasticsearch cluster's warm nodes"
  type        = string
  default     = "ultrawarm1.medium.elasticsearch"
}

variable "availability_zones" {
  description = "Whether zone awareness is enabled"
  type        = number
  default     = 3
}

variable "anonymous_auth_enabled" {
  description = "Whether Anonymous auth is enabled"
  type        = bool
  default     = false
}

variable "internal_user_database_enabled" {
  description = "Whether the internal user database is enabled"
  type        = bool
  default     = false
}

variable "master_user_name" {
  description = "Main user's username"
  type        = string
  default     = ""
}

variable "master_user_password" {
  description = "Main user's password"
  type        = string
  default     = ""
}

variable "ebs_enabled" {
  description = "Whether EBS volumes are attached to data nodes in the domain"
  type        = bool
  default     = true
}

variable "volume_type" {
  description = "Type of EBS volumes attached to data nodes"
  type        = string
  default     = "gp3"
}

variable "volume_size" {
  description = "Size of EBS volumes attached to data nodes (in GiB)"
  type        = number
  default     = 1024
}

variable "iops" {
  description = "Baseline input/output (I/O) performance of EBS volumes attached to data nodes"
  type        = number
  default     = 3000
}

variable "throughput" {
  description = "Specifies the throughput (in MiB/s)"
  type        = number
  default     = 250
}

variable "desired_state" {
  description = "Auto-Tune desired state for the domain"
  type        = string
  default     = "ENABLED"
}

variable "rollback_on_disable" {
  description = "Whether to roll back to default Auto-Tune settings when disabling Auto-Tune"
  type        = string
  default     = "NO_ROLLBACK"
}

variable "advanced_options" {
  description = "Key-value string pairs to specify advanced configuration options."
  type        = map(any)
  default = {
    "override_main_response_version" = "true"
  }
}

variable "saml_enabled" {
  description = "Whether SAML authentication is enabled"
  type        = bool
  default     = true
}

variable "entity_id" {
  description = "The unique Entity ID of the application in SAML Identity Provider"
  type        = string
  default     = ""
}

variable "metadata_content" {
  description = "The Metadata of the SAML application in xml format"
  type        = string
  default     = ""
}

variable "enforce_https" {
  description = " Whether or not to require HTTPS"
  type        = bool
  default     = true
}

variable "tls_security_policy" {
  description = "Name of the TLS security policy that needs to be applied to the HTTPS endpoint"
  type        = string
  default     = "Policy-Min-TLS-1-2-2019-07"
}

variable "enable_encrypt_at_rest" {
  description = "Whether to enable encryption at rest"
  type        = bool
  default     = true
}

variable "encrypt_kms_key_id" {
  description = "KMS key ARN to encrypt the Elasticsearch domain with"
  type        = string
  default     = ""
}

variable "custom_endpoint_enabled" {
  description = "Whether to enable custom endpoint for the OpenSearch domain"
  type        = bool
  default     = true
}

variable "custom_endpoint_certificate_arn" {
  description = "ACM certificate ARN for your custom endpoint"
  type        = string
  default     = ""
}

variable "node_to_node_encryption" {
  description = "Whether to enable node-to-node encryption"
  type        = bool
  default     = true
}

variable "dns_name" {
  description = "The name of the DNS record"
  type        = string
  default     = ""
}

variable "public_zone_id" {
  description = "The ID of the public hosted zone to contain this record"
  type        = string
  default     = ""
}

variable "private_zone_id" {
  description = "The ID of the private hosted zone to contain this record"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Map of tags to assign to the resource"
  type        = map(any)
  default     = {}
}

variable "create_linked_role" {
  description = "Define whether you need or not create service linked role"
  type        = bool
  default     = true
}

variable "autotune" {
  type    = string
  default = "ENABLED"
}