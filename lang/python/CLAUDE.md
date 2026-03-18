# Python Language Implementation — Conventions

This document is the authoritative reference for the Python implementation's
testing strategy, Makefile targets, CI structure, and shared tooling. Read it
before writing or modifying anything under `lang/python/`.

---

## Directory Layout

```
lang/python/
├── arch_tests/      Shared architecture test package (installed as dev dep in all three projects)
├── core/            AWS emulator server — FastAPI providers, CLI, orchestrator
├── sdk/             Testing SDK for user projects (lws_testing package)
├── example/         Reference project demonstrating SDK usage
└── Makefile         Root cascading Makefile
```

---

## Python Version

The canonical Python version is declared in:

```
lang/python/.python-version
```

Every `pyproject.toml` under `lang/python/` must set `requires-python` to match
this version. CI reads `.python-version` to configure the runner. Do not hard-code
a Python version anywhere else.

---

## Test Types and Ownership

| Test type | Core | SDK | Example |
|---|---|---|---|
| `unit` | `tests/unit/` | `tests/unit/` | `tests/unit/` |
| `integration` | `tests/integration/` | — | — |
| `e2e` | — | `tests/e2e/` | `tests/e2e/` |
| `architecture` | `tests/architecture/` | `tests/architecture/` | `tests/architecture/` |

**Core** has no e2e tests. The 41 service e2e suites live in the SDK.

**SDK** e2e tests use the `lws_testing` SDK fixtures (`lws_session`,
`aws_client`, etc.) — never raw boto3 or httpx.

**Example** e2e tests (previously named `acceptance-tests`) live in
`tests/e2e/` and follow Gherkin / pytest-bdd.

**Integration tests** (core only) use ASGI transport to test HTTP wire
protocol. No running server is required — they are not e2e tests.

---

## Makefile Targets

### Standard targets — must exist in `core/`, `sdk/`, and `example/`

| Target | Description |
|---|---|
| `unit-test` | `uv run pytest tests/unit` |
| `architecture-test` | `uv run pytest tests/architecture` |
| `e2e-test` | `uv run pytest tests/e2e` (sdk and example only; no-op in core) |
| `test` | `unit-test` + `architecture-test` |
| `lint` | `uvx ruff check src tests` |
| `format` | `uvx black src tests` |
| `format-check` | `uvx black --check src tests` |
| `complexity` | `uvx radon cc src -a -nc` (grade B or better) |
| `cpd` | `uvx --from pylint symilar -d 5` (no duplicates) |
| `pylint` | `uvx --from pylint pylint src/...` |
| `check` | `lint` + `format-check` + `complexity` + `cpd` + `pylint` + `test` |
| `install` | `uv sync` |
| `help` | Print available targets |

### Additional target — `core/` only

| Target | Description |
|---|---|
| `integration-test` | `uv run pytest tests/integration` |

`make test` in core runs `unit-test` + `integration-test` + `architecture-test`.

### Root `lang/python/Makefile` cascading behaviour

Calling a target at the root delegates to each sub-project in order:

| Root target | Delegates to |
|---|---|
| `unit-test` | core, sdk, example |
| `integration-test` | core |
| `architecture-test` | core, sdk, example |
| `e2e-test` | sdk, example |
| `check` | core, sdk, example |

Example:

```sh
# From repo root
make -C lang/python unit-test       # runs unit-test in core, sdk, example
make -C lang/python e2e-test        # runs e2e-test in sdk, example
make -C lang/python/sdk e2e-test    # runs sdk e2e only
```

---

## Architecture Tests Package

`lang/python/arch_tests/` is an installable package containing tests that
enforce coding and testing standards across all three projects. It is added as a
dev dependency in `core/`, `sdk/`, and `example/`.

### Universal tests (run in all three projects)

| File | What it enforces |
|---|---|
| `test_aaa_comments.py` | All test functions have `# Arrange` / `# Act` / `# Assert` comments |
| `test_no_bare_except.py` | No bare `except:` in `src/` |
| `test_no_magic_strings_in_assertions.py` | Assertions use `expected_*` / `actual_*` variables, no literals |
| `test_file_naming.py` | Test files named `test_<subject>_<scenario>.py` |
| `tests/unit/test_one_class_per_file.py` | One test class per file in `tests/unit/` |

### Universal e2e tests (run in sdk and example only)

| File | What it enforces |
|---|---|
| `tests/e2e/test_bdd_pattern.py` | E2E tests follow Gherkin BDD pattern |
| `tests/e2e/test_no_httpx_imports.py` | E2E step definitions do not import httpx directly |
| `tests/e2e/test_no_skipped_tests.py` | No `@skip` / `@wip` / `@xfail` in e2e scenarios |
| `tests/e2e/test_resource_naming.py` | E2E resource names follow naming conventions |

The architecture tests detect which project they are running in by reading
`ARCH_TESTS_SRC_ROOT` and `ARCH_TESTS_TESTS_ROOT` environment variables set in
each project's `conftest.py` before the shared tests run.

### Core-specific architecture tests (stay in `core/tests/architecture/` only)

These inspect core internals and do not belong in the shared package:

- `test_cli_command_test_coverage.py`
- `test_cli_resolve_resource_fallback.py`
- `test_cli_service_registration.py`
- `test_experimental_registry.py`
- `test_service_name_consistency.py`
- `tests/integration/test_async_consistency.py`
- `tests/integration/test_one_class_per_file.py`
- `tests/providers/` (all provider architecture tests)

### SDK-specific architecture tests (in `sdk/tests/architecture/` only)

- `test_provider_feature_e2e_coverage.py` — verifies every core provider has a
  corresponding e2e suite in `sdk/tests/e2e/`

---

## CI Job Naming and Structure

Job name format: `python-{project}-{target}`

### Core jobs

| Job | Make target | Needs Docker | Depends on |
|---|---|---|---|
| `python-core-lint` | `make -C lang/python/core lint format-check complexity cpd pylint` | No | — |
| `python-core-unit-test` | `make -C lang/python/core unit-test` | No | — |
| `python-core-integration-test` | `make -C lang/python/core integration-test` | No | — |
| `python-core-architecture-test` | `make -C lang/python/core architecture-test` | No | — |

### SDK jobs

| Job | Make target | Needs Docker | Depends on |
|---|---|---|---|
| `python-sdk-lint` | `make -C lang/python/sdk lint format-check complexity cpd pylint` | No | — |
| `python-sdk-unit-test` | `make -C lang/python/sdk unit-test` | No | — |
| `python-sdk-architecture-test` | `make -C lang/python/sdk architecture-test` | No | — |
| `python-sdk-e2e-test` | `make -C lang/python/sdk e2e-test` | Yes | `python-core-unit-test` |

### Example jobs

| Job | Make target | Needs Docker | Depends on |
|---|---|---|---|
| `python-example-lint` | `make -C lang/python/example lint format-check complexity cpd pylint` | No | — |
| `python-example-unit-test` | `make -C lang/python/example unit-test` | No | — |
| `python-example-architecture-test` | `make -C lang/python/example architecture-test` | No | — |
| `python-example-e2e-test` | `make -C lang/python/example e2e-test` | Yes | `python-sdk-e2e-test` |

### Change detection gating

| Gate | Triggered by changes to |
|---|---|
| `python-core-*` | `lang/python/core/**` or `lang/python/arch_tests/**` |
| `python-sdk-*` | `lang/python/sdk/**` or `lang/python/core/**` or `lang/python/arch_tests/**` |
| `python-example-*` | `lang/python/example/**` or `lang/python/sdk/**` or `lang/python/core/**` or `lang/python/arch_tests/**` |

### Docker setup for e2e jobs

E2e jobs that need Docker must pull Lambda base images before running:

```yaml
- run: docker pull public.ecr.aws/lambda/python:3.12
- run: docker pull public.ecr.aws/lambda/nodejs:20
```

The SDK e2e job also installs core as a local editable dependency:

```yaml
- run: uv pip install -e lang/python/core
```

The example e2e job installs both core and sdk:

```yaml
- run: uv pip install -e lang/python/core -e lang/python/sdk
```

---

## Adding a New Service E2E Suite

E2e suites live in `lang/python/sdk/tests/e2e/<service>/`. Each suite must contain:

```
tests/e2e/<service>/
├── conftest.py      Step definitions (Given/When/Then); no httpx imports
└── test_scenarios.py  pytest-bdd scenario runner; imports feature file
```

Feature files (`.feature`) live in `lang/specification/core/informal/<service>/`.

After adding a suite, `test_provider_feature_e2e_coverage.py` will automatically
verify it is wired up.
