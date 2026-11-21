.DEFAULT_GOAL := help

.PHONY: help install lint test-unit check

help:
	@echo "Targets:"
	@echo "  install          Install dependencies (pnpm install)"
	@echo "  lint             Type-check with tsc --noEmit"
	@echo "  test-unit        Run unit tests with Vitest"
	@echo "  check            lint + test-unit"

install:
	pnpm install

lint:
	pnpm exec tsc --noEmit

test-unit:
	pnpm exec vitest run tests/unit --reporter=verbose --reporter=junit --outputFile.junit=test-results/junit-unit.xml

check: lint test-unit
