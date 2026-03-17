.DEFAULT_GOAL := help

.PHONY: help test test-e2e check

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

test: ## Run test suite
	GRADLE_OPTS="-Dorg.gradle.project.buildDir=/tmp/gradle-build-lws-java-example" ./gradlew test

test-e2e: test ## Run e2e tests

check: test ## Run all checks
