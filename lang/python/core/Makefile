.DEFAULT_GOAL := help

.PHONY: help install lint format format-check complexity cpd pylint \
        test-unit test-architecture test-e2e-minimal test-e2e-guard test-e2e-sequence \
        unit-test integration-test architecture-test e2e-test test check

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-24s %s\n", $$1, $$2}'

install: ## Install dependencies
	uv sync

# ── Static analysis ──────────────────────────────────────────────────────────

lint: ## Run all static analysis: ruff, black --check, radon, cpd, pylint
	uvx ruff check --quiet src tests
	uvx black --check --quiet src tests
	@output=$$(uvx radon cc src -a -nc); \
	echo "$$output"; \
	echo "$$output" | grep -qE '^ +[A-Z]' && { echo "FAIL: complexity grade C or worse detected"; exit 1; } || true
	@output=$$(uvx --from pylint symilar -d 5 --ignore-imports --ignore-docstrings --ignore-signatures $$(find src -name "*.py")); \
	echo "$$output" | tail -1; \
	echo "$$output" | tail -1 | grep -q "duplicates=0 " || { echo "$$output"; exit 1; }
	uvx --from pylint pylint src/lws --recursive=y

format: ## Auto-format code
	uvx black src tests

format-check: ## Check formatting without changing files
	uvx black --check --quiet src tests

complexity: ## Check cyclomatic complexity (grade B or better)
	@output=$$(uvx radon cc src -a -nc); \
	echo "$$output"; \
	echo "$$output" | grep -qE '^ +[A-Z]' && { echo "FAIL: complexity grade C or worse detected"; exit 1; } || true

cpd: ## Check for copy-pasted code (5+ similar lines)
	@output=$$(uvx --from pylint symilar -d 5 --ignore-imports --ignore-docstrings --ignore-signatures $$(find src -name "*.py")); \
	echo "$$output" | tail -1; \
	echo "$$output" | tail -1 | grep -q "duplicates=0 " || { echo "$$output"; exit 1; }

pylint: ## Run pylint
	uvx --from pylint pylint src/lws --recursive=y

# ── Tests ─────────────────────────────────────────────────────────────────────

test-unit: ## Run unit and integration tests
	uv run pytest -q tests/unit tests/integration

test-architecture: ## Run architecture constraint tests
	uv run pytest -q tests/architecture

test-e2e-minimal: ## No-op: core has no e2e tests
	@true

test-e2e-guard: ## No-op: core has no e2e tests
	@true

test-e2e-sequence: ## No-op: core has no e2e tests
	@true

# ── Aliases (backward-compatible) ─────────────────────────────────────────────

unit-test: ## Run unit tests only
	uv run pytest -q tests/unit

integration-test: ## Run integration tests only
	uv run pytest -q tests/integration

architecture-test: test-architecture ## Alias for test-architecture

e2e-test: ## No-op: core has no e2e tests
	@true

test: test-unit test-architecture ## Run all tests

# ── Composite ─────────────────────────────────────────────────────────────────

check: lint test-unit test-architecture ## Run all checks (what CI runs)
