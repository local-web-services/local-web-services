# Change: Add TypeScript Core, SDK, and JavaScript SDK

## Why

Python is the only language that currently has a working LWS implementation. TypeScript and
JavaScript are first-class targets in the repository structure but `lang/typescript/` and
`lang/javascript/` do not exist. This change introduces the TypeScript core (emulator server),
TypeScript testing SDK, TypeScript example app, and the JavaScript SDK that wraps the TypeScript
core — bringing TypeScript/JavaScript users to full parity with Python.

## What Changes

- **NEW** `lang/typescript/core/` — TypeScript port of the Python AWS emulator server (all 20
  services, management API, provider lifecycle, CDK/Terraform parser)
- **NEW** `lang/typescript/sdk/` — TypeScript testing SDK (`LwsSession`, resource specs,
  `@aws-sdk` client helpers, Vitest fixtures)
- **NEW** `lang/typescript/example/` — Reference example app exercising the TypeScript SDK
- **NEW** `lang/javascript/sdk/` — JavaScript SDK that re-exports the TypeScript SDK without
  type annotations; published as `local-web-services-javascript-sdk` on npm
- **NEW** `lang/javascript/example/` — Reference example app exercising the JavaScript SDK
- **NEW** CI jobs for TypeScript/JavaScript lint, unit, architecture, and e2e tiers

## Phasing

This is a large change; it will be implemented in three phases, each merged independently:

| Phase | Scope |
|---|---|
| 1 | `lang/typescript/core/` — emulator server (providers, CLI, orchestrator, management API) |
| 2 | `lang/typescript/sdk/` + `lang/typescript/example/` — TypeScript testing SDK and example |
| 3 | `lang/javascript/sdk/` + `lang/javascript/example/` — JavaScript SDK wrapper and example |

## Impact

- Affected specs: `typescript-core`, `typescript-sdk`, `javascript-sdk` (all new)
- Affected code: new top-level directories under `lang/typescript/` and `lang/javascript/`
- Relevant ADRs: ADR-002 (TypeScript stack choices — framework, test runner, package manager)
