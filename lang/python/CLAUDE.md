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
| `lint` | ruff check + black --check + radon cc + cpd (symilar) + pylint |
| `test-unit` | `uv run pytest tests/unit` (+ `tests/integration` in core) |
| `test-architecture` | `uv run pytest tests/architecture` |
| `test-e2e-minimal` | E2E happy-path scenarios (`-m minimal`); no-op in core |
| `test-e2e-guard` | E2E guard-violation scenarios (`-m guard`); no-op in core |
| `test-e2e-sequence` | E2E multi-action chain scenarios (`-m sequence`); no-op in core |
| `e2e-test` | `test-e2e-minimal` + `test-e2e-guard` + `test-e2e-sequence` |
| `check` | `lint` + `test-unit` + `test-architecture` |
| `install` | `uv sync` |
| `help` | Print available targets |

Each tier writes JUnit XML to `test-results/junit-{tier}.xml` (e.g. `junit-minimal.xml`).

### SDK `SUITE` variable

The SDK `test-e2e-*` targets accept a `SUITE` variable to restrict the run to a
single service directory. Defaults to the full `tests/e2e/` tree:

```sh
make -C lang/python/sdk test-e2e-minimal                          # all suites
make -C lang/python/sdk test-e2e-minimal SUITE=tests/e2e/dynamodb # one suite
```

CI uses this to parallelise e2e across suites in a matrix job.

### Root `lang/python/Makefile` cascading behaviour

Calling a target at the root delegates to each sub-project in order:

| Root target | Delegates to |
|---|---|
| `lint` | core, sdk, example |
| `test-unit` | core, sdk, example |
| `test-architecture` | core, sdk, example |
| `test-e2e-minimal` | sdk, example |
| `test-e2e-guard` | sdk, example |
| `test-e2e-sequence` | sdk, example |
| `e2e-test` | sdk, example |
| `check` | core, sdk, example |

Example:

```sh
# From repo root
make -C lang/python test-unit           # runs test-unit in core, sdk, example
make -C lang/python test-e2e-minimal    # runs minimal e2e in sdk, example
make -C lang/python/sdk test-e2e-guard  # runs guard e2e in sdk only
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
| `test_file_naming.py` | Test files named `test_<subject>_<scenario>.py`; also allows `__init__`, `conftest`, `constants`, `client`, `_helpers` |
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
| `python-core-lint` | `make -C lang/python/core lint` | No | — |
| `python-core-test-unit` | `make -C lang/python/core test-unit` | No | — |
| `python-core-test-architecture` | `make -C lang/python/core test-architecture` | No | — |

### SDK jobs

| Job | Make target | Needs Docker | Depends on |
|---|---|---|---|
| `python-sdk-lint` | `make -C lang/python/sdk lint` | No | — |
| `python-sdk-test-unit` | `make -C lang/python/sdk test-unit` | No | — |
| `python-sdk-test-architecture` | `make -C lang/python/sdk test-architecture` | No | — |
| `python-sdk-e2e-suites` | discover e2e suite directories | No | `python-core-test-unit` |
| `python-sdk-test-e2e-minimal` | `make -C lang/python/sdk test-e2e-minimal SUITE=tests/e2e/${{ matrix.suite }}` | Yes | `python-sdk-e2e-suites` |
| `python-sdk-test-e2e-guard` | `make -C lang/python/sdk test-e2e-guard SUITE=tests/e2e/${{ matrix.suite }}` | Yes | `python-sdk-e2e-suites` |
| `python-sdk-test-e2e-sequence` | `make -C lang/python/sdk test-e2e-sequence SUITE=tests/e2e/${{ matrix.suite }}` | Yes | `python-sdk-e2e-suites` |
| `python-sdk-e2e-summary` | aggregate JUnit XML results | No | all three sdk e2e tier jobs |

The three `python-sdk-test-e2e-*` jobs run as a matrix (one job per suite directory),
parallelising e2e across all service suites.

### Example jobs

| Job | Make target | Needs Docker | Depends on |
|---|---|---|---|
| `python-example-lint` | `make -C lang/python/example lint` | No | — |
| `python-example-test-unit` | `make -C lang/python/example test-unit` | No | — |
| `python-example-test-architecture` | `make -C lang/python/example test-architecture` | No | — |
| `python-example-test-e2e-minimal` | `make -C lang/python/example test-e2e-minimal` | Yes | `python-sdk-e2e-summary` |
| `python-example-test-e2e-guard` | `make -C lang/python/example test-e2e-guard` | Yes | `python-sdk-e2e-summary` |
| `python-example-test-e2e-sequence` | `make -C lang/python/example test-e2e-sequence` | Yes | `python-sdk-e2e-summary` |
| `python-example-e2e-summary` | aggregate JUnit XML results | No | all three example e2e tier jobs |

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

The SDK e2e jobs also install core as a local editable dependency:

```yaml
- run: uv pip install -e lang/python/core
```

The example e2e jobs install both core and sdk:

```yaml
- run: uv pip install -e lang/python/core -e lang/python/sdk
```

## Pre-commit Hooks (lefthook)

`lefthook.yml` at the repo root configures a parallel pre-commit hook that runs
four checks simultaneously from `lang/python/`:

| Hook command | Make target |
|---|---|
| `python-lint` | `make lint` |
| `python-test-unit` | `make test-unit` |
| `python-test-architecture` | `make test-architecture` |
| `python-test-e2e-minimal` | `make test-e2e-minimal` |

Install hooks after cloning: `lefthook install`

---

## Adding a New Service E2E Suite

E2e suites live in `lang/python/sdk/tests/e2e/<service>/`. Each suite must contain:

```
tests/e2e/<service>/
├── __init__.py
├── client.py            PascalCaseTestClient (session helpers — boto3 calls)
├── conftest.py          fixtures + step registration (wildcard imports)
├── constants.py         constants (TEST_*) + pure helpers
├── test_scenarios.py    pytest-bdd scenario runner; loads feature files
├── given/
│   ├── __init__.py      aggregates: from .step_name import *  # noqa: F401,F403
│   └── <step_name>.py   one file per step
├── when/
│   ├── __init__.py
│   └── <step_name>.py
└── then/
    ├── __init__.py
    └── <step_name>.py
```

Feature files (`.feature`) live in `lang/specification/core/informal/<service>/`.

After adding a suite, `test_provider_feature_e2e_coverage.py` will automatically
verify it is wired up.

### client.py convention

Session helper functions (those taking `lws_session` as first param) belong in `client.py`,
not in `constants.py`. Name the class `<PascalCaseService>TestClient`. Step files import
from `..client`:

```python
# given/table_exists.py
from ..client import DynamodbTestClient

@given("the table exists")
def table_exists(lws_session):
    DynamodbTestClient(lws_session).create_table()
```

Use `tools/client_refactor.py` to generate `client.py` automatically from an existing
`constants.py`.
