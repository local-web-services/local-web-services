# Project Context

## Purpose

**Local Web Services (LWS)** is an AWS service emulator that lets developers run AWS services locally for fast, isolated testing — no Docker, cloud account, or mocks required. It provides in-process AWS service emulators that speak the native AWS wire protocol. Production code uses the normal AWS SDK; LWS intercepts requests via standard `AWS_ENDPOINT_URL_*` environment variables.

Key entry points:
- `ldk dev` — starts the local development server
- `lws` — AWS CLI-compatible client for interacting with running services

Supported services (21 total): API Gateway, DynamoDB, SQS, S3, SNS, EventBridge, Step Functions, Cognito IDP, Lambda, RDS, DocumentDB, SSM, Secrets Manager, ElastiCache, Neptune, MemoryDB, Glacier, Elasticsearch, OpenSearch, S3 Tables.

## Tech Stack

- **Python 3.11** — reference implementation (FastAPI + Uvicorn, Typer CLI, aiosqlite, httpx, pytest/pytest-bdd)
- **Go** — reference SDK implementation
- **Java** — reference SDK implementation (JUnit 5, Spotless formatter)
- **TypeScript / JavaScript** — reference SDK implementation
- **Bazel** — multi-language build orchestration
- **uv** — Python package management
- **SQLite** — persistent storage backend for DynamoDB and Cognito IDP
- **FizzBee** — formal model-checking for distributed system specs

## Project Conventions

### Code Style

- **Python:** Black (100-char line length), Ruff (E, F, I, W, UP, C90 rules), Pylint
- **Complexity:** Radon cyclomatic complexity ≤ grade B (≤10) per function
- **Imports:** stdlib → third-party → first-party (`lws`), managed by Ruff/isort
- **No magic strings in assertions** — always use `expected_*` / `actual_*` variables
- Architecture test package (`lang/python/arch_tests/`) enforces all conventions automatically

### Architecture Patterns

1. **Provider Pattern** — Every AWS emulator implements `start()`, `stop()`, `health_check()`, `flush()`
2. **Orchestrator** — Manages provider lifecycle using a topological dependency sort
3. **AppModel** — Single data structure capturing all infrastructure; parsed from CDK CloudFormation or Terraform state
4. **Middleware chain** (inner → outer): route handler → RequestLoggingMiddleware → AwsIamAuthMiddleware → AwsChaosMiddleware → AwsOperationMockMiddleware
5. **SDK Redirection** — `runtime/sdk_env.py` builds `AWS_ENDPOINT_URL_*` env vars so any AWS SDK routes automatically to local services

### Testing Strategy

Three-tier approach:

| Level | Directory | Runner | Notes |
|-------|-----------|--------|-------|
| Unit | `tests/unit/` | `make unit-test` | Single module, no I/O |
| Integration | `tests/integration/` | `make integration-test` | ASGI transport, no live server |
| E2E | `tests/e2e/` | `make test-e2e` | Gherkin/pytest-bdd, requires Docker |

Rules:
- Unit and integration tests **must** use Arrange / Act / Assert with `# Arrange` / `# Act` / `# Assert` comments
- E2E tests **must** use Gherkin feature files + pytest-bdd step definitions in `conftest.py`
- No `@skip`, `@wip`, `@xfail`, or `pytest.mark.skip` — configure CI to provide dependencies instead
- No magic strings in assertions
- Every new `lws` CLI command → Gherkin feature file + wiring file in `tests/e2e/<service>/`
- Every new public function/method → unit tests in `tests/unit/`
- API routing changes → integration tests in `tests/integration/`

Copy-paste detection: Symilar, 5+ duplicate lines in `src/` triggers failure (tests excluded).

### Git Workflow

- **Main branch:** `main`
- Feature branches created from `main`, merged via PR
- SDK releases are independently tagged: `python-sdk/v*`, `go-sdk/v*`, `typescript-sdk/v*`, `javascript-sdk/v*`, `java-sdk/v*`
- Commit messages: single-line summaries focused on the "what and why" of the change

## Domain Context

LWS emulates the AWS wire protocol — services run in-process and respond to real AWS SDK calls redirected via endpoint override environment variables. Each service runs on a dedicated port offset from a base port (e.g., DynamoDB = base+1, SQS = base+2). The `AppModel` is the central data structure built from CDK or Terraform output; it drives service wiring rather than hardcoded configuration.

The formal spec layer (`lang/specification/core/formal/`) uses FizzBee model checking to verify distributed system invariants. Informal specs (`lang/specification/core/informal/`) are Gherkin feature files that drive E2E test scenarios.

## Important Constraints

- **Quality Check Policy:** Never work around a failing lint/format/CPD/test check by disguising the violation. Fix the root cause. Suppressing checks requires explicit user approval.
- **Zero-defect test policy:** All tests must pass; no skips. If a test needs Docker, configure CI to provide it.
- **Spec-driven development:** New capabilities require an OpenSpec proposal (`openspec/changes/`) before implementation begins.
- **No mock databases in tests** — integration tests use ASGI transport against real in-process providers.

## External Dependencies

- **AWS SDK** (Python boto3, Go aws-sdk-go-v2, Java AWS SDK v2, TypeScript @aws-sdk) — used by tests and example apps to exercise emulated services
- **Docker** — required for E2E tests (Lambda compute, some storage backends)
- **GitHub Actions** — CI/CD (`/.github/workflows/ci.yml`); job naming convention: `python-{project}-{target}`
- **PyPI / npm / GitHub Packages** — SDK distribution targets
