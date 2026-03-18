.DEFAULT_GOAL := help

.PHONY: help install unit-test integration-test e2e-test architecture-test test lint format format-check complexity cpd type-check check

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

install: ## Install dependencies
	npm ci

unit-test: ## Run unit tests (Jest)
	npm run test:unit

integration-test: ## Run integration tests (none in sdk — skip)
	@echo "No integration tests in sdk — skipping"

e2e-test: ## Run e2e tests (Cucumber BDD)
	npm run test:e2e

architecture-test: ## Run architecture constraint tests
	npm run test:architecture

test: unit-test architecture-test ## Run all tests

lint: ## Lint source and tests
	npm run lint

format: ## Format source and tests
	npm run format

format-check: ## Check formatting without changing files
	npm run format-check

complexity: ## Check cyclomatic complexity (via lint)
	npm run complexity

cpd: ## Copy-paste detection
	npm run cpd

type-check: ## TypeScript type checking
	npm run type-check

check: lint format-check complexity cpd type-check test ## Run all checks
