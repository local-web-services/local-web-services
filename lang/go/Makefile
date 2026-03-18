.DEFAULT_GOAL := help

.PHONY: help check test-e2e

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

check: ## Run all checks for all Go packages
	$(MAKE) -C core check
	$(MAKE) -C sdk check
	$(MAKE) -C example check

test-e2e: ## Run e2e tests for all Go packages
	$(MAKE) -C core test-e2e
	$(MAKE) -C sdk test-e2e
	$(MAKE) -C example test-e2e
