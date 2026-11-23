.PHONY: install lint test\:unit check help

install:
	pnpm install

lint:
	pnpm exec tsc --noEmit

test\:unit:
	pnpm exec vitest run tests/unit

check: lint test\:unit

help:
	@echo "Targets: install lint test:unit check"
