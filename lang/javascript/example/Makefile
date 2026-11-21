.PHONY: install test\:unit check help

install:
	pnpm install

test\:unit:
	pnpm exec vitest run tests/unit

check: test\:unit

help:
	@echo "Targets: install test:unit check"
