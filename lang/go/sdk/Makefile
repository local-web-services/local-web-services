.DEFAULT_GOAL := help

.PHONY: help lint test test-e2e check

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

lint: ## Run go vet
	go vet ./...

test: ## Run test suite
	go test ./... -v

test-e2e: test ## Run e2e tests

check: lint test ## Run all checks
