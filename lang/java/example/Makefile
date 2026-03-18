.DEFAULT_GOAL := help

GRADLE_OPTS := -Dorg.gradle.project.buildDir=/tmp/gradle-build-lws-java-example
export GRADLE_OPTS

.PHONY: help test test-e2e e2e-test lint format format-check cpd spotbugs architecture-test check

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'

test: ## Run test suite
	./gradlew test

test-e2e: test ## Run e2e tests

e2e-test: test ## Run e2e tests

lint: ## Check style, imports, and complexity (Checkstyle)
	./gradlew checkstyleMain checkstyleTest

format: ## Auto-format code (Google Java Format via Spotless)
	./gradlew spotlessApply

format-check: ## Check formatting without changing files
	./gradlew spotlessCheck

cpd: ## Copy-paste detection (PMD — main sources only)
	./gradlew pmdMain

spotbugs: ## Static analysis (SpotBugs)
	./gradlew spotbugsMain

architecture-test: ## Run architecture constraint tests
	./gradlew architectureTest

check: lint format-check cpd spotbugs architecture-test test ## Run all checks
