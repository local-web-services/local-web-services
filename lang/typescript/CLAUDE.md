# TypeScript Language Implementation — Conventions

This document is the authoritative reference for the TypeScript implementation's
testing strategy, Makefile targets, CI structure, and shared tooling. Read it
before writing or modifying anything under `lang/typescript/`.

---

## Directory Layout

```
lang/typescript/
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
| `unit` | — | `tests/unit/` (Jest) | — |
| `bdd` | `tests/` (Cucumber.js) | `tests/` (Cucumber.js) | `tests/` (Cucumber.js) |
| `e2e / acceptance` | — | — | Cucumber.js BDD |

**Core** uses Cucumber.js (`npm test`) as its primary test suite. No separate unit tests.

**SDK** has both Jest unit tests (`npm run test:jest`) and Cucumber.js BDD tests (`npm test`).
CI runs `npm test` (Cucumber.js).

**Example** runs Jest tests (`npm test`) and Cucumber BDD acceptance tests (`npm run test:bdd`).
CI runs both in sequence.

---

## Makefile Targets

### Standard targets — must exist in `core/`, `sdk/`, and `example/`

| Target | Description |
|---|---|
| `test` | `npm ci && npm test` |
| `test-e2e` | `npm run test:bdd` (example); same as `test` for core and sdk |
| `check` | `test` (and `test-e2e` for example) |

### Root `lang/typescript/Makefile` cascading behaviour

| Root target | Delegates to |
|---|---|
| `check` | core, sdk, example |
| `test-e2e` | core, sdk, example |

Example:

```sh
# From repo root
make -C lang/typescript check        # runs check in core, sdk, example
make -C lang/typescript/core test    # runs npm test in core only
```

---

## Tooling

| Tool | Purpose | Config file |
|---|---|---|
| TypeScript | Language | `tsconfig.json` |
| ts-node | Runtime execution | — |
| tsup | SDK bundling | `tsup.config.ts` |
| ESLint | Linting | `.eslintrc` / `eslint.config.js` |
| Prettier | Formatting | `.prettierrc` |
| Cucumber.js | BDD tests (core, sdk, example) | `.cucumber.yml` |
| Jest | Unit tests (sdk, example) | `jest.config.ts` |

---

## Test Framework: Cucumber.js (BDD)

All three packages use Cucumber.js for behavioural tests. Feature files
(`.feature`) live in `lang/specification/core/informal/<service>/`.

Step definitions live in:
- `core/tests/steps/` — core-specific step implementations
- `sdk/tests/steps/` — sdk-specific step implementations
- `example/tests/steps/` — example-specific step implementations

Support files (world, hooks) live in the corresponding `tests/support/` directories.

---

## CI Job Naming and Structure

Job name format: `typescript-{project}-test`

### Jobs

| Job | Command | Needs Docker | Depends on |
|---|---|---|---|
| `typescript-core-test` | `npm ci && npm test` in `lang/typescript/core` | No | — |
| `typescript-sdk-test` | `npm ci && npm test` in `lang/typescript/sdk` | No | `typescript-core-test` |
| `typescript-example-test` | Jest + Cucumber BDD in `lang/typescript/example` | No | `typescript-sdk-test` |

The example job runs two steps:
1. Build the SDK: `npm ci && npm run build` in `lang/typescript/sdk`
2. Jest: `npm ci && npm test` in `lang/typescript/example`
3. BDD: `npm run test:bdd` in `lang/typescript/example`

### Change detection gating

All three jobs are gated on the `typescript` filter:

```
lang/typescript/core/**
lang/typescript/sdk/**
lang/typescript/example/**
```

A change to any file under `lang/typescript/` triggers all three jobs.

---

## Adding a New Service

Each new service needs:

1. A provider file at `lang/typescript/core/src/providers/<service>/index.ts`
2. A store file at `lang/typescript/core/src/providers/<service>/store.ts`
3. Registration in `lang/typescript/core/src/server.ts` with a port offset
4. SDK client builder in `lang/typescript/sdk/src/session.ts`
5. A Gherkin feature file in `lang/specification/core/informal/<service>/`
6. Step definitions wired into `lang/typescript/sdk/tests/steps/`
