# Change: Add Java parity with Python management APIs and provider features

## Why

The Java implementation on `parity-check` received handler expansions across 12 providers and full BDD E2E test files for all 92 service combinations, but the management API surface is unchanged: Java has no chaos injection endpoint, no fake server endpoint, no lifecycle rule endpoint, no state injection endpoint, and no capacity enforcement across its providers.

This mirrors the gap Python closed over the past sprint cycle (proposals `add-python-fake-chaos-sdk-access`, `add-python-capacity-parity`, `add-python-async-state-injection`). This proposal ports those same capabilities to Java.

## What Changes

- **Management API — chaos endpoint**: Add `GET/PUT/DELETE /_ldk/chaos/{service}` to Java's management controller
- **Management API — fake server endpoint**: Add `GET/POST /_ldk/fake` and `GET /_ldk/fake/{name}` to the management controller
- **Management API — lifecycle endpoint**: Add `GET/POST /_ldk/lifecycle` to the management controller (mirrors Go and Python)
- **Management API — state injection endpoint**: Add `GET/PUT/DELETE /_ldk/state/{service}/{resourceType}/{resourceId}` to the management controller
- **Capacity enforcement**: Add `CapacityConfig` and per-service capacity guards to all Java provider handlers (currently none enforce capacity)
- **Fakeserver provider**: Add `lang/java/core/src/main/java/io/localwebservices/lws/providers/fakeserver/` matching the Python fakeserver provider
- **SDK helpers**: Add `setChaos`, `resetChaos`, `getChaosStatus`, `injectState`, `clearInjectedState` methods to the Java SDK `LwsSession` class; add `client("fake")` and `client("aws_fake")` support
- **Unit tests**: Add unit tests for chaos config, capacity enforcement, and state injection

## Impact

- Affected specs: `python-fake-chaos-sdk-access`, `python-capacity-parity`, `python-async-state-injection`
- Affected code: `lang/java/core/src/main/java/io/localwebservices/lws/` (management controller, all providers), `lang/java/sdk/`
- No breaking changes — all new endpoints are additive; existing Java provider behaviour is preserved
