.PHONY: gherkin gherkin-exhaustive sloc check test-e2e fizz-check install-hooks

define run_gherkin
	@for spec in lang/specification/core/formal/*/*.fizz lang/specification/core/formal/integrations/*/*.fizz; do \
		service=$$(basename $$(dirname $$spec)); \
		python3 tools/fizz_to_gherkin.py "$$spec" \
			--tier $(1) \
			--service "$$(echo $$service | sed 's/_/ /g' | awk '{for(i=1;i<=NF;i++) $$i=toupper(substr($$i,1,1)) substr($$i,2)}1' | tr -d ' ')" \
			--output "lang/specification/core/informal/$$service/"; \
	done
endef


# Generate Gherkin feature files (happy path + negative + action sequences)
gherkin-exhaustive:
	$(call run_gherkin,exhaustive)

# Default: exhaustive tier (happy path + guard violations + sequences)
gherkin: gherkin-exhaustive

# Run FizzBee model checker on all formal specs (skipped if fizz not in PATH)
fizz-check: ## Run FizzBee model checker on all formal specs
	@if ! command -v fizz >/dev/null 2>&1; then \
		echo "fizz-check: SKIPPED (fizz not in PATH)"; \
	else \
		failed=0; \
		for spec in lang/specification/core/formal/*/*.fizz lang/specification/core/formal/integrations/*/*.fizz; do \
			echo "Checking: $$spec"; \
			timeout 120 fizz "$$spec" || { echo "FAILED: $$spec"; failed=1; }; \
		done; \
		exit $$failed; \
	fi

# Run all checks across every language and formal specs
check: ## Run all checks (all languages + FizzBee specs)
	$(MAKE) -C lang/python check
	$(MAKE) -C lang/typescript check
	$(MAKE) -C lang/java check
	$(MAKE) -C lang/go check
	$(MAKE) fizz-check

# Run e2e tests across every language and formal specs
test-e2e: ## Run e2e tests (all languages + FizzBee specs)
	$(MAKE) -C lang/python test-e2e
	$(MAKE) -C lang/typescript test-e2e
	$(MAKE) -C lang/java test-e2e
	$(MAKE) -C lang/go test-e2e
	$(MAKE) fizz-check

# Install git hooks from scripts/hooks/ into .git/hooks/
install-hooks: ## Install pre-commit hook (symlink from scripts/hooks/)
	@ln -sf "$(shell pwd)/scripts/hooks/pre-commit" .git/hooks/pre-commit
	@echo "Installed pre-commit hook."

# Count source lines of code across the project
sloc: ## Count source lines of code
	@command -v tokei >/dev/null 2>&1 || { echo "tokei not found. Install with: brew install tokei"; exit 1; }
	@tokei . --exclude node_modules --exclude .venv --exclude __pycache__ --exclude .gradle --exclude build --exclude dist --exclude out --exclude allure-results
