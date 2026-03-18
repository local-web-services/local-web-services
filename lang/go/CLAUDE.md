# Go Language Implementation — Conventions

This document is the authoritative reference for the Go implementation's
testing strategy, Makefile targets, CI structure, and shared tooling. Read it
before writing or modifying anything under `lang/go/`.

---

## Directory Layout

```
lang/go/
├── core/            AWS emulator server — net/http handlers
│   ├── lws/         Main source packages
│   ├── tests/       Go test files (*_test.go)
│   ├── go.mod
│   └── Makefile
├── sdk/             Testing SDK for user projects
│   ├── lws/         Main source packages
│   ├── tests/       Go test files (*_test.go)
│   └── Makefile
├── example/         Reference project demonstrating SDK usage
└── Makefile         Root cascading Makefile
```

---

## Go Version

The canonical Go version is `1.23` (as configured in CI via `actions/setup-go`).
The `go.mod` in each module declares this version. Do not hard-code a version
anywhere else.

---

## Test Types and Ownership

| Test type | Core | SDK | Example |
|---|---|---|---|
| `unit / integration` | `tests/*_test.go` | `tests/*_test.go` | `*_test.go` |
| `bdd` | Uses Godog (Cucumber for Go) | Uses Godog | — |

All tests are Go native test files (`*_test.go`). BDD-style tests use the
`godog` library (Cucumber for Go) but are still run via `go test ./...`.

No separate test type split — `go test ./...` runs everything.

---

## Makefile Targets

### Standard targets — must exist in `core/`, `sdk/`, and `example/`

| Target | Description |
|---|---|
| `test` | `go test ./...` (core: `-v`; sdk: `-v`) |
| `test-e2e` | `go test ./tests/... -v` (core); same as `test` for sdk and example |
| `lint` | `go vet ./...` (sdk only; not in core or example) |
| `check` | `lint test` (sdk); `test` (core, example) |

### Root `lang/go/Makefile` cascading behaviour

| Root target | Delegates to |
|---|---|
| `check` | core, sdk, example |
| `test-e2e` | core, sdk, example |

Example:

```sh
# From repo root
make -C lang/go check              # runs check in core, sdk, example
make -C lang/go/core test          # runs go test ./... in core only
make -C lang/go/sdk lint           # runs go vet ./... in sdk
```

---

## Tooling

| Tool | Purpose |
|---|---|
| `go test` | Test runner (all test types) |
| `go vet` | Linting / static analysis |
| `godog` | Cucumber BDD framework (dev dependency in `go.mod`) |

There is no separate formatter step in the Makefile, but `gofmt` conventions
apply to all source files.

---

## Test Structure

Tests follow standard Go conventions:

- Test files are named `*_test.go` alongside or in a `tests/` subdirectory
- BDD step definitions use `godog` and register via `InitializeScenario`
- Feature files (`.feature`) live in `lang/specification/core/informal/<service>/`

---

## BDD Tag Conventions

The BDD runner in `core/tests/bdd_test.go` applies the tag filter:

```
(@minimal or @standard) and not @internal
```

### `@internal` — permanently excluded scenarios

Tag a scenario `@internal` in the feature file when it requires an **internal
or private API** to force the system into a state that the public AWS API
cannot create. Examples:

- A resource is in `DELETING` state (AWS transitions this internally; there is
  no public API call that puts a resource into `DELETING` and leaves it there)
- A capacity slot is exhausted (`no item slot is available`, `no execution slot
  is available`) — the fake has no public API to drain capacity
- A resource is `PENDING_DELETION` with a recovery window still open

These scenarios are excluded from the standard run **permanently by design**.
They are not "not yet implemented" — they are fundamentally untestable via
public APIs in a local fake.

### `godog.ErrSkip` — do not use

`godog.ErrSkip` returned from a step definition silently skips the scenario at
runtime after it has already matched the tag filter. This is equivalent to
`pytest.mark.skip` and is **not permitted**.

- If a scenario is untestable via public APIs → tag it `@internal` in the
  feature file instead
- If a scenario's behaviour is not yet implemented in the Go fake → implement
  it; do not skip it

### Unimplemented cross-service behaviour

Scenarios that test cross-service behaviour (e.g. S3→SNS notifications,
SNS→SQS fanout, StepFunctions task execution) use only public APIs and reach
reachable states. They are not `@internal`. If the Go fake has not implemented
the behaviour yet, the step definition must be written and the implementation
must be added. Using `godog.ErrSkip` as a placeholder for unimplemented work
is not acceptable.

---

## CI Job Naming and Structure

Job name format: `go-{project}-{lint|test}`

### Jobs

| Job | Command | Needs Docker | Depends on |
|---|---|---|---|
| `go-core-lint` | `make format-check` in `lang/go/core` | No | — |
| `go-core-test` | `make test` in `lang/go/core` | No | — |
| `go-sdk-lint` | `make lint format-check` in `lang/go/sdk` | No | `go-core-lint`, `go-core-test` |
| `go-sdk-test` | `make test` in `lang/go/sdk` | No | `go-core-lint`, `go-core-test` |
| `go-example-lint` | `make format-check` in `lang/go/example` | No | `go-sdk-lint`, `go-sdk-test` |
| `go-example-test` | `make test` in `lang/go/example` | No | `go-sdk-lint`, `go-sdk-test` |

### Change detection gating

Each project has its own filter that cascades upstream paths:

| Filter | Paths |
|---|---|
| `go-core` | `lang/go/core/**`, `lang/specification/**` |
| `go-sdk` | `lang/go/sdk/**`, `lang/go/core/**`, `lang/specification/**` |
| `go-example` | `lang/go/example/**`, `lang/go/sdk/**`, `lang/go/core/**`, `lang/specification/**` |

---

## Adding a New Service

Each new service needs:

1. Source package at `lang/go/core/lws/<service>/`
2. Registration in `lang/go/core/lws/server.go` with a port offset
3. SDK client helper in `lang/go/sdk/lws/session.go`
4. Test file at `lang/go/core/tests/<service>_test.go`
5. A Gherkin feature file in `lang/specification/core/informal/<service>/`
6. Step definitions wired via `godog` in the test package
