.DEFAULT_GOAL := help

.PHONY: help test test-e2e check

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

test: ## Run test suite
	npm test

test-e2e: ## Run e2e tests
	npm test

check: test ## Run all checks
