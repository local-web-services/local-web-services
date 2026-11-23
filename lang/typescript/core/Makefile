.DEFAULT_GOAL := help

.PHONY: help install lint test-unit test-integration check

help:
	@echo "Targets:"
	@echo "  install           Install dependencies (pnpm install)"
	@echo "  lint              Type-check with tsc --noEmit"
	@echo "  test-unit         Run unit tests with Vitest"
	@echo "  test-integration  Run integration tests with Vitest"
	@echo "  check             lint + test-unit + test-integration"

install:
	pnpm install

lint:
	pnpm exec tsc --noEmit

test-unit:
	pnpm exec vitest run tests/unit --reporter=verbose --reporter=junit --outputFile.junit=test-results/junit-unit.xml

test-integration:
	pnpm exec vitest run tests/integration --reporter=verbose --reporter=junit --outputFile.junit=test-results/junit-integration.xml

check: lint test-unit test-integration
