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

## CI Job Naming and Structure

Job name format: `go-{project}-test`

### Jobs

| Job | Command | Needs Docker | Depends on |
|---|---|---|---|
| `go-core-test` | `go test ./...` in `lang/go/core` | No | — |
| `go-sdk-test` | `go test ./...` in `lang/go/sdk` | No | `go-core-test` |
| `go-example-test` | `go test ./...` in `lang/go/example` | No | `go-sdk-test` |

### Change detection gating

All three jobs are gated on the `go` filter:

```
lang/go/**
```

A change to any file under `lang/go/` triggers all three jobs.

---

## Adding a New Service

Each new service needs:

1. Source package at `lang/go/core/lws/<service>/`
2. Registration in `lang/go/core/lws/server.go` with a port offset
3. SDK client helper in `lang/go/sdk/lws/session.go`
4. Test file at `lang/go/core/tests/<service>_test.go`
5. A Gherkin feature file in `lang/specification/core/informal/<service>/`
6. Step definitions wired via `godog` in the test package
