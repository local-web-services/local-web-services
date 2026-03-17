.DEFAULT_GOAL := help

.PHONY: help test test-e2e check

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

test: ## Run test suite
	go test ./...

test-e2e: test ## Run e2e tests

check: test ## Run all checks
