.DEFAULT_GOAL := help

# Pass SUITE=tests/e2e/<name> to target a single suite; defaults to all suites.
SUITE ?= tests/e2e

.PHONY: help install lint format format-check complexity cpd pylint \
        test-unit test-architecture test-e2e-minimal test-e2e-guard test-e2e-sequence \
        unit-test architecture-test e2e-test test check

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-24s %s\n", $$1, $$2}'

install: ## Install dependencies
	uv sync --all-groups

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
	uvx --from pylint pylint src/lws_testing --recursive=y

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
	uvx --from pylint pylint src/lws_testing --recursive=y

# ── Tests ─────────────────────────────────────────────────────────────────────

test-unit: ## Run unit tests
	uv run pytest -q tests/unit

test-architecture: ## Run architecture constraint tests
	uv run pytest -q tests/architecture

# Pass SUITE=tests/e2e/<name> on the command line to target one suite.
test-e2e-minimal: ## Run @minimal e2e scenarios (requires Docker)
	uv run pytest $(SUITE) -v -m "minimal and not internal and not lifecycle and not capacity" --junitxml=test-results/junit-minimal.xml

test-e2e-guard: ## Run @guard e2e scenarios (requires Docker)
	uv run pytest $(SUITE) -v -m "guard and not internal and not lifecycle and not capacity" --junitxml=test-results/junit-guard.xml

test-e2e-sequence: ## Run @sequence e2e scenarios (requires Docker)
	uv run pytest $(SUITE) -v -m "sequence and not internal and not lifecycle and not capacity" --junitxml=test-results/junit-sequence.xml

# ── Aliases (backward-compatible) ─────────────────────────────────────────────

unit-test: test-unit ## Alias for test-unit

architecture-test: test-architecture ## Alias for test-architecture

e2e-test: test-e2e-minimal test-e2e-guard test-e2e-sequence ## Run all e2e scenarios (requires Docker)

test: test-unit test-architecture ## Run all non-e2e tests

# ── Composite ─────────────────────────────────────────────────────────────────

check: lint test-unit test-architecture ## Run all checks (what CI runs)
