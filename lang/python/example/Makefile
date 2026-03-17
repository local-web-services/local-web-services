.DEFAULT_GOAL := help

.PHONY: help test test-e2e check

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

test: ## Run test suite
	uv run --extra test pytest

test-e2e: ## Run e2e tests
	uv run --extra test pytest

check: test ## Run all checks
