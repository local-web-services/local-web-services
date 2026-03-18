.DEFAULT_GOAL := help

.PHONY: help unit-test integration-test architecture-test e2e-test check

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

unit-test: ## Run unit tests across all packages
	$(MAKE) -C core unit-test
	$(MAKE) -C sdk unit-test
	$(MAKE) -C example unit-test

integration-test: ## Run integration tests (core only)
	$(MAKE) -C core integration-test

architecture-test: ## Run architecture tests across all packages
	$(MAKE) -C core architecture-test
	$(MAKE) -C sdk architecture-test
	$(MAKE) -C example architecture-test

e2e-test: ## Run e2e tests (sdk and example)
	$(MAKE) -C sdk e2e-test
	$(MAKE) -C example e2e-test

check: ## Run all checks for all TypeScript packages
	$(MAKE) -C core check
	$(MAKE) -C sdk check
	$(MAKE) -C example check
