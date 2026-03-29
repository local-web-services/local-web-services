## 1. Management API — Chaos Endpoint
- [ ] 1.1 Add `ChaosConfig` struct (`ErrorRate float64`, `LatencyMs int`) to `lang/go/core/lws/state/state.go`
- [ ] 1.2 Add `SetChaosConfig` / `GetChaosConfig` / `ResetChaosConfig` to `ServerState`
- [ ] 1.3 Add `GET/PUT/DELETE /_ldk/chaos/{service}` handler to `management.go`
- [ ] 1.4 Add chaos injection middleware helper that checks `ChaosConfig` before each request in provider handlers
- [ ] 1.5 Wire chaos middleware into all provider handlers

## 2. Management API — Fake Server Endpoint
- [ ] 2.1 Add `FakeServerRecord` struct and `fake_servers` map to `ServerState`
- [ ] 2.2 Add `GET/POST /_ldk/fake` and `GET /_ldk/fake/{name}` handler to `management.go`
- [ ] 2.3 Create `lang/go/core/lws/providers/fakeserver/handler.go` with basic fake endpoint routing

## 3. Management API — State Injection Endpoint
- [ ] 3.1 Add injected-state map to `ServerState`
- [ ] 3.2 Add `GET/PUT/DELETE /_ldk/state/{service}/{resource_type}/{resource_id}` handler to `management.go`
- [ ] 3.3 Wire state injection into StepFunctions and Lambda provider handlers

## 4. Capacity Enforcement
- [ ] 4.1 Add `CapacityConfig` struct and per-service capacity map to `ServerState`
- [ ] 4.2 Add `GET /_ldk/capacity/{service}`, `PUT /_ldk/capacity/{service}` (already exists for some), `DELETE /_ldk/capacity/{service}` — verify all are present
- [ ] 4.3 Add capacity guard helper and apply to all provider handlers that lack it

## 5. SDK Helpers
- [ ] 5.1 Add `SetChaos(service, errorRate, latencyMs)` to Go SDK session
- [ ] 5.2 Add `ResetChaos(service)` to Go SDK session
- [ ] 5.3 Add `GetChaosStatus(service)` to Go SDK session
- [ ] 5.4 Add `InjectState(service, resourceType, resourceID, state)` to Go SDK session
- [ ] 5.5 Add `ClearInjectedState(service, resourceType, resourceID)` to Go SDK session

## 6. Tests
- [ ] 6.1 Verify `chaos`, `aws_fake`, `fake` E2E suites in `lang/go/sdk/tests/` have real scenarios (not stubs)
- [ ] 6.2 Add unit tests for chaos config in `lang/go/core/lws/` matching Python unit test coverage
- [ ] 6.3 Run `make test` in `lang/go/` and confirm all suites green
