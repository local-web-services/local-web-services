.DEFAULT_GOAL := help

.PHONY: help lint test-unit test-architecture test-e2e-minimal test-e2e-guard test-e2e-sequence \
        unit-test integration-test architecture-test e2e-test check all

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-24s %s\n", $$1, $$2}'

lint: ## Run all static analysis for all Python packages
	$(MAKE) -C core lint
	$(MAKE) -C sdk lint
	$(MAKE) -C example lint

test-unit: ## Run unit (and integration) tests for all Python packages
	$(MAKE) -C core test-unit
	$(MAKE) -C sdk test-unit
	$(MAKE) -C example test-unit

test-architecture: ## Run architecture constraint tests for all Python packages
	$(MAKE) -C core test-architecture
	$(MAKE) -C sdk test-architecture
	$(MAKE) -C example test-architecture

test-e2e-minimal: ## Run @minimal e2e scenarios for sdk and example (requires Docker)
	$(MAKE) -C sdk test-e2e-minimal
	$(MAKE) -C example test-e2e-minimal

test-e2e-guard: ## Run @guard e2e scenarios for sdk and example (requires Docker)
	$(MAKE) -C sdk test-e2e-guard
	$(MAKE) -C example test-e2e-guard

test-e2e-sequence: ## Run @sequence e2e scenarios for sdk and example (requires Docker)
	$(MAKE) -C sdk test-e2e-sequence
	$(MAKE) -C example test-e2e-sequence

# ── Aliases ───────────────────────────────────────────────────────────────────

unit-test: ## Run unit tests for all Python packages (alias for test-unit)
	$(MAKE) test-unit

integration-test: ## Run integration tests (core only)
	$(MAKE) -C core integration-test

architecture-test: ## Run architecture tests for all Python packages (alias for test-architecture)
	$(MAKE) test-architecture

e2e-test: ## Run all e2e scenarios for sdk and example (requires Docker)
	$(MAKE) test-e2e-minimal test-e2e-guard test-e2e-sequence

check: ## Run all checks for all Python packages
	$(MAKE) -C core check
	$(MAKE) -C sdk check
	$(MAKE) -C example check

all: check e2e-test ## Run everything: all checks + e2e tests (requires Docker)
