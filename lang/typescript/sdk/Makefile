.PHONY: install lint test\:unit test\:e2e check help

install:
	pnpm install

lint:
	pnpm exec tsc --noEmit

test\:unit:
	pnpm exec vitest run tests/unit --reporter=verbose --reporter=junit --outputFile.junit=test-results/junit-unit.xml

test\:e2e:
	NODE_NO_WARNINGS=1 node --loader ts-node/esm node_modules/.bin/cucumber-js --config cucumber.mjs

check: lint test\:unit

help:
	@echo "Targets: install lint test:unit test:e2e check"
