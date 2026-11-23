## Context

The TypeScript core must faithfully replicate the Python emulator's wire-protocol behaviour while
fitting naturally into the Node.js ecosystem. Key constraints:

- Must speak the same AWS wire protocols as the Python core (JSON target dispatch, form-encoded
  SQS, REST S3)
- Providers must run in-process (no Docker) on separate ports, matching the Python port-offset
  scheme
- The testing SDK API surface must mirror the Python `lws_testing` package so that the same
  Gherkin feature files drive both implementations
- JavaScript SDK must be usable without TypeScript tooling (plain `require`/`import`)

## Goals / Non-Goals

- Goals:
  - Full feature parity with Python core across all 20 services
  - TypeScript-first SDK with complete type information for `@aws-sdk` clients
  - JavaScript CJS + ESM dual build
  - Same three-tier test structure: unit / integration / e2e
  - Shared Gherkin feature files from `lang/specification/core/informal/` drive e2e
- Non-Goals:
  - Webpack/browser bundle (Node.js only)
  - Cross-compiling Lambda handlers (Lambda compute still runs Python/Node subprocesses)

## Decisions

### HTTP framework: Fastify

- **Decision:** Use [Fastify](https://fastify.dev) for all provider HTTP servers.
- **Alternatives considered:**
  - *Express* — ubiquitous but no built-in async or TypeScript support; slower than Fastify.
  - *Hono* — excellent TypeScript support and very lightweight; less ecosystem depth for plugins.
  - *Fastify* — mature, fastest Node.js HTTP framework in benchmarks, first-class TypeScript
    types, schema-based validation via `@fastify/ajv-compiler`, good plugin model for middleware
    parity with Python's Starlette middleware chain.
- **Rationale:** Fastify's plugin system maps cleanly onto the Python middleware chain
  (chaos → IAM auth → logging → route handler). Its `inject()` method enables ASGI-style
  integration tests without a running server, matching the Python integration test approach.

### Test runner: Vitest

- **Decision:** Use [Vitest](https://vitest.dev) for unit and integration tests.
- **Alternatives considered:**
  - *Jest* — widely used but slow cold-start, CommonJS-first, requires Babel for ESM.
  - *Vitest* — ESM-native, TypeScript-native, Jest-compatible API, fast watch mode,
    built-in coverage via v8.
- **Rationale:** Vitest requires zero transform config for TypeScript + ESM, matching the
  zero-config philosophy of the Python stack (`uv` + `pytest`).

### E2E test runner: Cucumber.js (cucumber-js)

- **Decision:** Use [cucumber-js](https://github.com/cucumber/cucumber-js) for e2e Gherkin
  scenarios, mirroring the Python pytest-bdd approach.
- **Rationale:** Shares feature files from `lang/specification/core/informal/` without
  modification. `cucumber-js` is the reference Gherkin runner for JavaScript.

### Package manager: pnpm

- **Decision:** Use [pnpm](https://pnpm.io) for all TypeScript/JavaScript packages.
- **Alternatives considered:**
  - *npm* — universal, but slow installs and flat `node_modules` cause phantom dependency issues.
  - *yarn* — popular but adds complexity; two versions (classic/berry) in the ecosystem.
  - *pnpm* — symlinked `node_modules`, workspace support via `pnpm-workspace.yaml`,
    fast installs, used by many large monorepos.
- **Rationale:** Workspace support across `lang/typescript/` and `lang/javascript/` with a single
  root `pnpm-workspace.yaml` mirrors the Python root `Makefile` cascading approach.

### Module format: ESM + CJS dual build

- **Decision:** Publish TypeScript SDK as dual ESM + CJS via `tsup`.
- **Rationale:** Ensures compatibility with both modern ESM projects and legacy CJS consumers
  (Jest, older Node.js toolchains). `tsup` handles the dual-build with minimal config.

### JavaScript SDK strategy: re-export from TypeScript SDK

- **Decision:** `lang/javascript/sdk/` is a thin package that re-exports the compiled JS output
  of `lang/typescript/sdk/` with no `.d.ts` type declarations in the published package.
- **Rationale:** Single implementation, no duplication. TypeScript users import the TS package;
  JavaScript users import the JS package which is the same runtime code minus type overhead.

### SQLite backend: better-sqlite3

- **Decision:** Use `better-sqlite3` (synchronous) for DynamoDB and Cognito persistence.
- **Rationale:** `better-sqlite3` is the most performant SQLite binding for Node.js; synchronous
  API matches the in-process provider model and avoids async complexity in SQLite operations.

## Risks / Trade-offs

- **Port parity:** TypeScript core must bind to the same port offsets as Python. CI must ensure
  both cores are never started simultaneously on the same port in test runs.
- **SQLite prebuilt binaries:** `better-sqlite3` ships native addons; CI must run
  `npm rebuild better-sqlite3` after install if the Node.js version changes.
- **Gherkin step sharing:** Feature files are shared; step definitions must be re-implemented in
  TypeScript/JavaScript. Steps are not shared across language implementations.

## Open Questions

- Should `lang/typescript/core/` include a full CDK CloudFormation parser, or start with the
  management API + providers only (CDK parsing deferred to Phase 2)?
  → **Decision deferred to Phase 1 implementation.**
