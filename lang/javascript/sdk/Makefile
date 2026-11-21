.PHONY: install build lint test\:unit check help

install:
	pnpm install

build:
	pnpm exec tsup

lint:
	pnpm exec tsc --noEmit

test\:unit:
	pnpm exec vitest run tests/unit

check: lint build test\:unit

help:
	@echo "Targets: install build lint test:unit check"
