.PHONY: gherkin gherkin-minimal gherkin-standard gherkin-exhaustive sloc test-e2e

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

# Default: standard tier
gherkin: gherkin-exhaustive

# Run e2e tests for all languages
test-e2e:
	$(MAKE) -C lang/python test-e2e
	$(MAKE) -C lang/go test-e2e
	$(MAKE) -C lang/java test-e2e
	$(MAKE) -C lang/typescript test-e2e

# Count source lines of code across the project
sloc:
	@command -v tokei >/dev/null 2>&1 || { echo "tokei not found. Install with: brew install tokei"; exit 1; }
	@tokei . --exclude node_modules --exclude .venv --exclude __pycache__ --exclude .gradle --exclude build --exclude dist --exclude out --exclude allure-results
