.DEFAULT_GOAL := help

.PHONY: help install check

help:
	@echo "Targets:"
	@echo "  install  Install dependencies (pnpm install)"
	@echo "  check    Run architecture tests with Vitest"

install:
	pnpm install

check:
	pnpm exec vitest run tests --reporter=verbose --reporter=junit --outputFile.junit=test-results/junit-arch.xml
