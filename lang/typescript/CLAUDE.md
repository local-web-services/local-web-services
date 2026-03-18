# TypeScript Language Implementation — Conventions

This document is the authoritative reference for the TypeScript implementation's
testing strategy, Makefile targets, CI structure, and shared tooling. Read it
before writing or modifying anything under `lang/typescript/`.

---

## Directory Layout

```
lang/typescript/
├── arch_tests/      Shared architecture test package (installed as dev dep in all three projects)
├── core/            AWS emulator server — Fastify-based HTTP providers
├── sdk/             Testing SDK for user projects (lws_testing npm package)
├── example/         Reference project demonstrating SDK usage
└── Makefile         Root cascading Makefile
```

---

## Node.js Version

The canonical Node.js version is `20` (as configured in CI via `actions/setup-node`).
Every `package.json` under `lang/typescript/` must declare `"engines": { "node": ">=18.0.0" }`
or higher. Do not hard-code a version anywhere else.

---

## Test Types and Ownership

| Test type | Core | SDK | Example |
|---|---|---|---|
| `unit` | — | `tests/unit/` (Jest) | `tests/*.test.ts` (Jest) |
| `integration` | `tests/` (Cucumber.js) | — | — |
| `e2e` | — | `tests/` (Cucumber.js) | `tests/acceptance-tests/` (Cucumber.js) |
| `architecture` | `tests/architecture/` | `tests/architecture/` | `tests/architecture/` |

**Core** uses Cucumber.js as its integration test suite — the BDD scenarios exercise
the HTTP server directly. No separate unit tests exist in core.

**SDK** has Jest unit tests (`tests/unit/`) and Cucumber.js e2e tests (`tests/`).

**Example** has Jest unit tests (`tests/*.test.ts`) and Cucumber.js acceptance tests
(`tests/acceptance-tests/`).

---

## Makefile Targets

### Standard targets — must exist in `core/`, `sdk/`, and `example/`

| Target | Description |
|---|---|
| `unit-test` | Jest unit tests (sdk: `npm run test:unit`, example: `npm test`, core: N/A — prints skip message) |
| `integration-test` | Cucumber BDD (core only: `npm test`; no-op in sdk and example) |
| `e2e-test` | Cucumber BDD (sdk + example: `npm run test:e2e`; no-op in core) |
| `architecture-test` | Architecture constraint tests (`npm run test:architecture`) |
| `test` | `unit-test` + `integration-test` + `architecture-test` |
| `lint` | `npm run lint` → ESLint over `src/` and `tests/` |
| `format` | `npm run format` → Prettier write |
| `format-check` | `npm run format-check` → Prettier check |
| `complexity` | `npm run complexity` → ESLint max-complexity rule check |
| `cpd` | `npm run cpd` → jscpd copy-paste detection |
| `type-check` | `npm run type-check` → `tsc --noEmit` |
| `check` | `lint` + `format-check` + `complexity` + `cpd` + `type-check` + `test` |
| `install` | `npm ci` |
| `help` | Print available targets |

### Root `lang/typescript/Makefile` cascading behaviour

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
make -C lang/typescript unit-test          # runs unit-test in core, sdk, example
make -C lang/typescript e2e-test           # runs e2e-test in sdk, example
make -C lang/typescript/sdk e2e-test       # runs sdk e2e only
```

---

## Architecture Tests Package

`lang/typescript/arch_tests/` is an npm package containing tests that enforce
coding and testing standards across all three projects. It is added as a dev
dependency in `core/`, `sdk/`, and `example/`.

### Universal tests (run in all three projects)

| File | What it enforces |
|---|---|
| `src/tests/aaa-comments.test.ts` | All test functions have `// Arrange` / `// Act` / `// Assert` comments |
| `src/tests/no-magic-strings.test.ts` | Assertions use `expected*` / `actual*` variables, no string literals |
| `src/tests/no-skipped-tests.test.ts` | No `xit`, `xdescribe`, `test.skip`, `it.skip` in test files |
| `src/tests/file-naming.test.ts` | Test files named `*.test.ts` or `*Steps.ts` or `*steps.ts` |

### Universal e2e tests (run in sdk and example only)

| File | What it enforces |
|---|---|
| `src/tests/e2e/no-skipped-scenarios.test.ts` | No `@skip` / `@wip` in Gherkin scenarios |
| `src/tests/e2e/resource-naming.test.ts` | E2E resource names follow `test-<service>-<n>` conventions |

The architecture tests detect which project they are running in by reading
the `LWS_ARCH_PROJECT_ROOT` environment variable set in each project's
`tests/architecture/jest.config.ts` before the shared tests run.

### SDK-specific architecture tests (in `sdk/tests/architecture/` only)

- `provider-e2e-coverage.test.ts` — verifies every core provider has a
  corresponding e2e suite in `sdk/tests/`

---

## Tooling

| Tool | Purpose | Config file |
|---|---|---|
| TypeScript | Language | `tsconfig.json` |
| ts-node | Runtime execution | — |
| tsup | SDK bundling | `tsup.config.ts` |
| ESLint | Linting + complexity | `.eslintrc.json` |
| Prettier | Formatting | `../.prettierrc` (shared) |
| jscpd | Copy-paste detection | — |
| Cucumber.js | Integration / e2e tests | `cucumber.yml` |
| Jest | Unit + architecture tests | `jest.config.ts` |

---

## CI Job Naming and Structure

Job name format: `typescript-{project}-{target}`

### Core jobs

| Job | Make target | Needs Docker | Depends on |
|---|---|---|---|
| `typescript-core-lint` | `make -C lang/typescript/core lint format-check complexity cpd type-check` | No | — |
| `typescript-core-integration-test` | `make -C lang/typescript/core integration-test` | No | — |
| `typescript-core-architecture-test` | `make -C lang/typescript/core architecture-test` | No | — |

### SDK jobs

| Job | Make target | Needs Docker | Depends on |
|---|---|---|---|
| `typescript-sdk-lint` | `make -C lang/typescript/sdk lint format-check complexity cpd type-check` | No | — |
| `typescript-sdk-unit-test` | `make -C lang/typescript/sdk unit-test` | No | — |
| `typescript-sdk-architecture-test` | `make -C lang/typescript/sdk architecture-test` | No | — |
| `typescript-sdk-e2e-test` | `make -C lang/typescript/sdk e2e-test` | No | `typescript-core-integration-test` |

### Example jobs

| Job | Make target | Needs Docker | Depends on |
|---|---|---|---|
| `typescript-example-lint` | `make -C lang/typescript/example lint format-check complexity cpd type-check` | No | — |
| `typescript-example-unit-test` | `make -C lang/typescript/example unit-test` | No | — |
| `typescript-example-architecture-test` | `make -C lang/typescript/example architecture-test` | No | — |
| `typescript-example-e2e-test` | `make -C lang/typescript/example e2e-test` | No | `typescript-sdk-e2e-test` |

### Change detection gating

| Gate | Triggered by changes to |
|---|---|
| `typescript-core-*` | `lang/typescript/core/**` or `lang/typescript/arch_tests/**` |
| `typescript-sdk-*` | `lang/typescript/sdk/**` or `lang/typescript/core/**` or `lang/typescript/arch_tests/**` |
| `typescript-example-*` | `lang/typescript/example/**` or `lang/typescript/sdk/**` or `lang/typescript/core/**` or `lang/typescript/arch_tests/**` |

---

## Feature Files Are Read-Only

Feature files in `lang/specification/` are the **canonical source of truth**
for behaviour across all language implementations. **Never edit them to work
around a limitation in a specific language's fake** — fix the fake instead.
The only permitted reason to modify a feature file is a deliberate change to
the shared specification itself.

---

## Adding a New Service

Each new service needs:

1. A provider file at `lang/typescript/core/src/providers/<service>/index.ts`
2. A store file at `lang/typescript/core/src/providers/<service>/store.ts`
3. Registration in `lang/typescript/core/src/server.ts` with a port offset
4. SDK client builder in `lang/typescript/sdk/src/session.ts`
5. A Gherkin feature file in `lang/specification/core/informal/<service>/`
6. Step definitions wired into `lang/typescript/core/tests/steps/`
7. E2e step definitions wired into `lang/typescript/sdk/tests/steps/`
