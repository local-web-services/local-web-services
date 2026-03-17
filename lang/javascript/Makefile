.DEFAULT_GOAL := help

.PHONY: help check test-e2e

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

check: ## Run all checks for all JavaScript packages
	$(MAKE) -C core check

test-e2e: ## Run e2e tests for all JavaScript packages
	$(MAKE) -C core test-e2e
