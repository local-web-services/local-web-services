.DEFAULT_GOAL := help

.PHONY: help unit-test integration-test architecture-test e2e-test check all

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'

unit-test: ## Run unit tests for all Python packages
	$(MAKE) -C core unit-test
	$(MAKE) -C sdk unit-test
	$(MAKE) -C example unit-test

integration-test: ## Run integration tests (core only)
	$(MAKE) -C core integration-test

architecture-test: ## Run architecture constraint tests for all Python packages
	$(MAKE) -C core architecture-test
	$(MAKE) -C sdk architecture-test
	$(MAKE) -C example architecture-test

e2e-test: ## Run e2e tests for sdk and example (requires Docker)
	$(MAKE) -C sdk e2e-test
	$(MAKE) -C example e2e-test

check: ## Run all checks for all Python packages
	$(MAKE) -C core check
	$(MAKE) -C sdk check
	$(MAKE) -C example check

all: check e2e-test ## Run everything: all checks + e2e tests (requires Docker)
