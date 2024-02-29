define HELP_MESSAGE
List of available targets:

init        initialize terraform and tflint
validate    perform code syntax validation
fmt         format code
lint        perform code linting
docss        generate docs
endef

.PHONY: help init validate fmt lint docs

export HELP_MESSAGE
help:
	@echo "$$HELP_MESSAGE"

init:
	terraform init
	tflint --init

validate:
	terraform validate

TERRAFORM_FMT_ARGS?=-list=true -write=true -diff
fmt:
	terraform fmt $(TERRAFORM_FMT_ARGS) .

TFLINT_ARGS?=-c .tflint.hcl
lint:
	tflint $(TFLINT_ARGS)
	tfsec --config-file .tfsec.yaml .

docs:
	terraform-docs -c .terraform-docs.yaml .