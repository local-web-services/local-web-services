.DEFAULT_GOAL := help

.PHONY: help check test-e2e lint format-check cpd spotbugs architecture-test

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'

lint: ## Run lint checks for all Java packages
	$(MAKE) -C core lint
	$(MAKE) -C sdk lint
	$(MAKE) -C example lint

format-check: ## Check formatting for all Java packages
	$(MAKE) -C core format-check
	$(MAKE) -C sdk format-check
	$(MAKE) -C example format-check

cpd: ## Run copy-paste detection for all Java packages
	$(MAKE) -C core cpd
	$(MAKE) -C sdk cpd
	$(MAKE) -C example cpd

spotbugs: ## Run static analysis for all Java packages
	$(MAKE) -C core spotbugs
	$(MAKE) -C sdk spotbugs
	$(MAKE) -C example spotbugs

architecture-test: ## Run architecture tests for all Java packages
	$(MAKE) -C core architecture-test
	$(MAKE) -C sdk architecture-test
	$(MAKE) -C example architecture-test

check: ## Run all checks for all Java packages
	$(MAKE) -C core check
	$(MAKE) -C sdk check
	$(MAKE) -C example check

test-e2e: ## Run e2e tests for all Java packages
	$(MAKE) -C core test-e2e
	$(MAKE) -C sdk test-e2e
	$(MAKE) -C example test-e2e
