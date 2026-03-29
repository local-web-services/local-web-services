# Change: Add TypeScript parity with Python management APIs and provider features

## Why

The TypeScript implementation on `parity-check` has the largest gap of any language relative to Python. Python implemented:
- Chaos injection management API (`/_ldk/chaos/{service}`)
- Fake server management API (`/_ldk/fake`)
- Lifecycle rule management API (`/_ldk/lifecycle`)
- Capacity enforcement across all 16 providers
- State injection management API (`/_ldk/state/...`)
- A complete `fakeserver` provider
- Full cross-service dispatch routing (APIGateway→Cognito, Lambda→all services, StepFunctions tasks)

TypeScript on `parity-check` received only: SSM provider expansion and E2E BDD test files. The management APIs, provider dispatch routing, and SDK helpers are all missing.

## What Changes

- **Management API — chaos endpoint**: Add `GET/PUT/DELETE /_ldk/chaos/{service}` to the TypeScript management router
- **Management API — fake server endpoint**: Add `GET/POST /_ldk/fake` and `GET /_ldk/fake/{name}` to the management router
- **Management API — state injection endpoint**: Add `GET/PUT/DELETE /_ldk/state/{service}/{resource_type}/{resource_id}` to the management router
- **Capacity enforcement**: Add `CapacityConfig` and per-service capacity guards to all TypeScript provider handlers (currently only partially implemented)
- **Lifecycle rules**: Verify `/_ldk/lifecycle` is implemented in TypeScript (it exists in Go and Python); add if missing
- **Fakeserver provider**: Add `lang/typescript/core/src/providers/fakeserver/` matching the Python fakeserver provider
- **Cross-service dispatch — APIGateway→Cognito**: Port `_apigateway_v1_authorizers.ts` Cognito authorizer support
- **SDK helpers**: Add `setChaos`, `resetChaos`, `getChaosStatus`, `injectState`, `clearInjectedState` to the TypeScript SDK `LwsSession` class
- **E2E scenarios**: Enable `chaos`, `aws_fake`, `fake`, `apigateway_cognito` suites in TypeScript SDK tests

## Impact

- Affected specs: `python-fake-chaos-sdk-access`, `python-capacity-parity`, `python-async-state-injection`, `python-apigateway-cognito-authorizer`
- Affected code: `lang/typescript/core/src/` (management, all providers), `lang/typescript/sdk/src/`
- No breaking changes — all new endpoints are additive; existing TypeScript provider behavior is preserved
