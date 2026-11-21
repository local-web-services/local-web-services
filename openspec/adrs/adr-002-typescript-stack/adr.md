# ADR-002: TypeScript Stack Choices (Framework, Test Runner, Package Manager)

## Status
Accepted

## Context

Adding `lang/typescript/` requires choosing an HTTP framework for the emulator providers, a test
runner, a package manager, and an approach to the JavaScript SDK. These choices must support:
- TypeScript-first development with strict types
- In-process testing without a running server (matching Python's ASGI transport approach)
- ESM and CJS dual-publish for the SDKs
- Monorepo workspace management across `lang/typescript/` and `lang/javascript/`

## Options Considered

### HTTP framework

- **Express** — ubiquitous, wide ecosystem, but no built-in async, TypeScript types are
  third-party (`@types/express`), and benchmarks show it as the slowest mainstream option.
- **Hono** — excellent TypeScript support, very lightweight, edge-runtime compatible, but smaller
  plugin ecosystem and less production battle-testing at scale.
- **Fastify** — mature, fastest Node.js HTTP framework in benchmarks, first-class TypeScript
  support, schema-based validation, `inject()` method for in-process testing without a socket,
  large plugin ecosystem.

### Test runner

- **Jest** — widely used, slow cold-start, CommonJS-first, requires Babel/`ts-jest` transform for
  TypeScript + ESM.
- **Vitest** — ESM-native, TypeScript-native (no transform needed), Jest-compatible API, fast
  watch mode, built-in v8 coverage.

### E2E runner

- **playwright/test** — excellent for browser + API testing, but heavier than needed for CLI-level
  BDD scenarios.
- **cucumber-js** — the reference Gherkin/BDD runner for JavaScript; shares `.feature` files from
  `lang/specification/core/informal/` without modification.

### Package manager

- **npm** — universal, flat `node_modules` creates phantom dependency risks in a monorepo.
- **yarn** — workspace support but two incompatible versions (classic/berry) in the ecosystem.
- **pnpm** — symlinked `node_modules` (strict hoisting), native workspace support via
  `pnpm-workspace.yaml`, fast installs.

### JavaScript SDK strategy

- **Duplicate source** — maintain a separate JavaScript source tree; high maintenance burden.
- **Re-export compiled output** — `lang/javascript/sdk/` is a thin package that re-exports the
  compiled JS output of `lang/typescript/sdk/` with no `.d.ts` files in the published package.

## Decision

| Concern | Choice |
|---|---|
| HTTP framework | **Fastify** |
| Unit/integration test runner | **Vitest** |
| E2E test runner | **cucumber-js** |
| Package manager | **pnpm** (workspace root at `lang/`) |
| JavaScript SDK | Re-export from TypeScript SDK compiled output |
| SQLite binding | **better-sqlite3** (synchronous, highest throughput) |
| JWT (Cognito) | **jose** (pure ESM, no native deps) |

## Rationale

- Fastify's `inject()` enables in-process integration tests identical to Python's ASGI transport,
  without opening a real socket. Its plugin system maps directly onto the Python Starlette
  middleware chain.
- Vitest requires zero configuration for TypeScript + ESM, matching the simplicity of the Python
  `uv` + `pytest` stack.
- cucumber-js allows the same `.feature` files in `lang/specification/core/informal/` to drive
  both Python (pytest-bdd) and TypeScript/JavaScript (cucumber-js) e2e suites.
- pnpm workspaces with a single `pnpm-workspace.yaml` at `lang/` mirrors the Python root
  `Makefile` cascading approach.
- Re-exporting from TypeScript SDK compiled output keeps a single implementation, eliminating
  drift between TypeScript and JavaScript SDKs.

## Consequences / Limitations

- `better-sqlite3` requires native addon compilation; CI must rebuild after Node.js version changes.
- `jose` is ESM-only; any consumer that requires CJS must use dynamic `import()`.
- pnpm is not installed by default on all machines; CI and contributing docs must specify
  `corepack enable && corepack prepare pnpm@latest --activate`.
- Fastify's plugin encapsulation model differs from Starlette's middleware; the middleware order
  must be explicitly tested to match the Python behaviour.
