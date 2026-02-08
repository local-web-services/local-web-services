.DEFAULT_GOAL := help

.PHONY: help install lint format format-check complexity test check

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

install: ## Install dependencies
	uv sync

lint: ## Run linter
	uv run ruff check src tests

format: ## Auto-format code
	uv run black src tests

format-check: ## Check formatting without changing files
	uv run black --check src tests

complexity: ## Check cyclomatic complexity (fail on C+ grades)
	uv run radon cc src -a -nc

test: ## Run test suite
	uv run pytest

check: lint format-check complexity test ## Run all checks (what CI runs)
