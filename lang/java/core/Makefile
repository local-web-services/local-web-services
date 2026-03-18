.DEFAULT_GOAL := help

.PHONY: help test test-e2e lint format format-check cpd spotbugs architecture-test check

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'

test: ## Run test suite
	GRADLE_OPTS="-Dorg.gradle.project.buildDir=/tmp/gradle-build-lws-java-core" ./gradlew test

test-e2e: test ## Run e2e tests

lint: ## Check style, imports, and complexity (Checkstyle)
	GRADLE_OPTS="-Dorg.gradle.project.buildDir=/tmp/gradle-build-lws-java-core" ./gradlew checkstyleMain checkstyleTest

format: ## Auto-format code (Google Java Format via Spotless)
	GRADLE_OPTS="-Dorg.gradle.project.buildDir=/tmp/gradle-build-lws-java-core" ./gradlew spotlessApply

format-check: ## Check formatting without changing files
	GRADLE_OPTS="-Dorg.gradle.project.buildDir=/tmp/gradle-build-lws-java-core" ./gradlew spotlessCheck

cpd: ## Copy-paste detection (PMD — main sources only)
	GRADLE_OPTS="-Dorg.gradle.project.buildDir=/tmp/gradle-build-lws-java-core" ./gradlew pmdMain

spotbugs: ## Static analysis (SpotBugs)
	GRADLE_OPTS="-Dorg.gradle.project.buildDir=/tmp/gradle-build-lws-java-core" ./gradlew spotbugsMain

architecture-test: ## Run architecture constraint tests
	GRADLE_OPTS="-Dorg.gradle.project.buildDir=/tmp/gradle-build-lws-java-core" ./gradlew architectureTest

check: lint format-check cpd spotbugs architecture-test test ## Run all checks
