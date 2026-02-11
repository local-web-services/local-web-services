.DEFAULT_GOAL := help

.PHONY: help install lint format format-check complexity cpd pylint test test-e2e check

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

install: ## Install dependencies
	uv sync

lint: ## Run linter
	uvx ruff check src tests

format: ## Auto-format code
	uvx black src tests

format-check: ## Check formatting without changing files
	uvx black --check src tests

complexity: ## Check cyclomatic complexity (all functions must be grade B or better)
	uvx radon cc src -a -nc

cpd: ## Check for copy-pasted code (5+ similar lines)
	@output=$$(uvx --from pylint symilar -d 5 --ignore-imports --ignore-docstrings --ignore-signatures $$(find src -name "*.py")); \
	echo "$$output" | tail -1; \
	echo "$$output" | tail -1 | grep -q "duplicates=0 " || { echo "$$output"; exit 1; }

pylint: ## Run pylint checks
	uvx --from pylint pylint src/lws --recursive=y

test: ## Run test suite (excludes e2e)
	uv run pytest --ignore=tests/e2e

test-e2e: ## Run e2e tests (no Docker required)
	uv run pytest tests/e2e/ -v

check: lint format-check complexity cpd pylint test ## Run all checks (what CI runs)
