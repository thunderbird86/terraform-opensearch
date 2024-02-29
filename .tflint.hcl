# https://github.com/terraform-linters/tflint/blob/master/docs/user-guide/config.md
config {
  format = "compact"
  plugin_dir = "~/.tflint.d/plugins"

  disabled_by_default = false
}

# https://github.com/terraform-linters/tflint-ruleset-terraform
# This is an example of enabling/disabling tflint rules: 
#
# rule "aws_instance_invalid_type" {
#   enabled = false
# }