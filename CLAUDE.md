<!-- OPENSPEC:START -->
# OpenSpec Instructions

These instructions are for AI assistants working in this project.

Always open `@/openspec/AGENTS.md` when the request:
- Mentions planning or proposals (words like proposal, spec, change, plan)
- Introduces new capabilities, breaking changes, architecture shifts, or big performance/security work
- Sounds ambiguous and you need the authoritative spec before coding

Use `@/openspec/AGENTS.md` to learn:
- How to create and apply change proposals
- Spec format and conventions
- Project structure and guidelines

Keep this managed block so 'openspec update' can refresh the instructions.

<!-- OPENSPEC:END -->

# Contributing Guidelines

Before writing or modifying code, read the relevant contributing guides:

- `contributing/ARCHITECTURE.md` — system design, directory structure, core concepts, request flow
- `contributing/testing/COMMON.md` — shared test rules: AAA pattern, variable naming, magic string extraction
- `contributing/testing/UNIT.md` — unit test standards, file naming, fixtures, async patterns
- `contributing/testing/INTEGRATION.md` — integration test standards, wire protocols, HTTP patterns
- `contributing/testing/END_TO_END.md` — E2E test standards, `lws_invoke`/`assert_invoke` fixtures, resource naming
- `contributing/LINTING.md` — linting, formatting, complexity checks, `make check` details

When adding a new feature:
- Every new `lws` CLI command requires an E2E test in `tests/e2e/<service>/test_<command>.py`
- Every new public function or method requires unit tests in `tests/unit/`
- API routing changes require integration tests in `tests/integration/`
- All tests must follow Arrange / Act / Assert with `# Arrange` / `# Act` / `# Assert` comments
- No magic strings in assertions — use `expected_*` and `actual_*` variables