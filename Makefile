.DEFAULT_GOAL := help

.PHONY: help install lint format format-check complexity test check

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

complexity: ## Check cyclomatic complexity (fail on C+ grades)
	uvx radon cc src -a -nc

test: ## Run test suite
	uv run pytest

check: lint format-check complexity test ## Run all checks (what CI runs)
