# Change: Add Go parity with Python management APIs and provider features

## Why

The Python implementation on `parity-check` is significantly ahead of Go in three areas:
1. **Management API completeness** — Python has chaos injection (`/_ldk/chaos/{service}`), fake server management (`/_ldk/fake`), and capacity enforcement that Go lacks.
2. **Provider feature gaps** — Several provider handlers in Go are missing validation guards, capacity enforcement, and cross-service notification logic that Python already implements.
3. **SDK test helpers** — The Go `LwsSession` equivalent lacks `SetChaos`, `ResetChaos`, `GetChaosStatus`, `InjectState`, and `ClearInjectedState` methods that the Python SDK exposes.

This proposal closes the gap so Go reaches full feature parity with the Python implementation.

## What Changes

- **Management API — chaos endpoint**: Add `GET/PUT/DELETE /_ldk/chaos/{service}` to `lang/go/core/lws/management.go`
- **Management API — fake server endpoint**: Add `GET/POST /_ldk/fake` and `GET /_ldk/fake/{name}` to `lang/go/core/lws/management.go`
- **Capacity enforcement**: Port `capacity_control.py` pattern to Go — add `CapacityConfig` struct and per-service capacity guards to provider handlers that lack them (DynamoDB, Lambda, SQS, SNS, StepFunctions, Glacier, S3Tables, SecretsMgr, SSM, ElastiCache, MemoryDB, Neptune, DocDB, RDS, OpenSearch, Elasticsearch)
- **State injection API**: Add `GET/PUT/DELETE /_ldk/state/{service}/{resource_type}/{resource_id}` to management.go
- **SDK helpers**: Add `SetChaos`, `ResetChaos`, `GetChaosStatus`, `InjectState`, `ClearInjectedState` helpers to `lang/go/sdk/` session type
- **Fakeserver provider**: Add `lang/go/core/lws/providers/fakeserver/handler.go` matching Python's `fakeserver` provider
- **E2E scenarios**: Enable the `chaos`, `aws_fake`, and `fake` E2E test suites in `lang/go/sdk/tests/` (these files exist but scenarios may be stubbed)
- **CI**: No new CI jobs required — existing Go SDK E2E matrix already runs all suites

## Impact

- Affected specs: `python-fake-chaos-sdk-access`, `python-capacity-parity`, `python-async-state-injection`
- Affected code: `lang/go/core/lws/management.go`, `lang/go/core/lws/state/state.go`, `lang/go/core/lws/providers/*/handler.go` (all services), `lang/go/sdk/`
- No breaking changes — all new endpoints are additive
