.DEFAULT_GOAL := help

.PHONY: help lint format-check test test-e2e e2e-test-suite check

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

lint: ## Run go vet
	go vet ./...

format-check: ## Check gofmt formatting (fails if any files are unformatted)
	@test -z "$$(gofmt -l .)" || (echo "Unformatted files:" && gofmt -l . && exit 1)

test: ## Run test suite
	go test ./... -v

test-e2e: test ## Run e2e tests

e2e-test-suite: ## Run a single e2e suite: make e2e-test-suite SUITE=<service> or SUITE=sdk
	GODOG_SUITE="$(SUITE)" go test ./... -v

check: lint format-check test ## Run all checks
