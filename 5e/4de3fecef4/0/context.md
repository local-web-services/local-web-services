# Session Context

**Session ID:** 2c1da5b5-66a2-4ca5-ad8d-26a15fc081b5

**Commit Message:** I want to make test-e2e run as a pre commit hook and in CI

## Prompt

I want to make test-e2e run as a pre commit hook and in CI

## Summary

Done. Here's what changed:

- **Pre-commit hook** (`.git/hooks/pre-commit`): Now runs `make test-e2e` after `make check`
- **CI** (`ci.yml`): Added `test-e2e` as a 4th parallel job
- **Publish** (`publish.yml`): Added `test-e2e` as a 4th parallel job; `build` now depends on it
- **LINTING.md**: Added section 7 for e2e tests, updated check count and descriptions

## Key Actions

- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/.git/hooks/pre-commit
- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/.github/workflows/ci.yml
- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/.github/workflows/publish.yml
- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/contributing/LINTING.md
- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/contributing/LINTING.md
- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/contributing/LINTING.md
- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/contributing/LINTING.md
