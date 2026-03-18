.DEFAULT_GOAL := help

.PHONY: help format-check test test-e2e check

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

format-check: ## Check gofmt formatting (fails if any files are unformatted)
	@test -z "$$(gofmt -l .)" || (echo "Unformatted files:" && gofmt -l . && exit 1)

test: ## Run test suite
	go test ./...

test-e2e: test ## Run e2e tests

check: format-check test ## Run all checks
