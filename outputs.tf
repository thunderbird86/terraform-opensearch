output "arn" {
  description = "ARN of the domain"
  value       = aws_opensearch_domain.this.arn
}

output "domain_id" {
  description = "Unique identifier for the domain"
  value       = aws_opensearch_domain.this.domain_id
}

output "domain_name" {
  description = "Name of the OpenSearch domain"
  value       = aws_opensearch_domain.this.domain_name
}

output "endpoint" {
  description = "Domain-specific endpoint used to submit index, search, and data upload requests"
  value       = aws_opensearch_domain.this.endpoint
}

output "kibana_endpoint" {
  description = "Domain-specific endpoint for kibana without https scheme"
  value       = aws_opensearch_domain.this.kibana_endpoint
}
