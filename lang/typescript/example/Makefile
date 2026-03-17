.DEFAULT_GOAL := help

.PHONY: help test test-e2e check

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

test: ## Run unit tests (Jest)
	npm ci && npm test

test-e2e: ## Run acceptance tests (Cucumber)
	npm run test:acceptance-tests

check: test test-e2e ## Run all checks
