## 1. Management API — per-service chaos path
- [ ] 1.1 Add `mux.HandleFunc("/_ldk/chaos/", ...)` to `management.go` (path-param extraction for `{service}`)
- [ ] 1.2 Implement `PUT /_ldk/chaos/{service}` — accept `{"error_rate", "latency_ms"}`, call `state.SetChaosRule(service, "*", rule)`
- [ ] 1.3 Implement `GET /_ldk/chaos/{service}` — return config for that service only
- [ ] 1.4 Implement `DELETE /_ldk/chaos/{service}` — call `state.DisableChaos(service)`
- Note: `ChaosRule` struct and `SetChaosRule`/`DisableChaos` methods already exist in `state/state.go`

## 2. Management API — per-service capacity path
- [ ] 2.1 Add `mux.HandleFunc("/_ldk/capacity/", ...)` to `management.go`
- [ ] 2.2 Implement `PUT /_ldk/capacity/{service}` — accept `{"slots": int|null}`, call `state.SetCapacityRule`
- [ ] 2.3 Implement `GET /_ldk/capacity/{service}` — return config for that service
- [ ] 2.4 Implement `DELETE /_ldk/capacity/{service}` — reset to unlimited (nil slots)
- Note: `CapacityRule` struct and `SetCapacityRule`/`GetCapacityRule` already exist in `state/state.go`

## 3. Management API — fake server instances (`/_ldk/fake`)
- [ ] 3.1 Add `fakeServers map[string]string` to `ServerState` in `state/state.go`
- [ ] 3.2 Add `RegisterFakeServer(name, endpoint string)`, `GetFakeServer(name string) string`, `ListFakeServers() map[string]string` to `state/state.go`
- [ ] 3.3 Add `POST /_ldk/fake` handler in `management.go` — accept `{"name", "endpoint"}`
- [ ] 3.4 Add `GET /_ldk/fake` handler — list all registered servers
- [ ] 3.5 Add `GET /_ldk/fake/{name}` handler — return single record

## 4. Management API — state injection (`/_ldk/state`)
- [ ] 4.1 Add `injectedStates map[string]string` to `ServerState` (key: `service:resourceType:resourceId`)
- [ ] 4.2 Add `SetInjectedState`, `ClearInjectedState`, `GetInjectedState` to `state/state.go`
- [ ] 4.3 Add `mux.HandleFunc("/_ldk/state/", ...)` to `management.go` with PUT/DELETE/GET
- [ ] 4.4 Wire `GetInjectedState("stepfunctions", "execution", id)` into StepFunctions handler (override describe/list status)
- [ ] 4.5 Wire `GetInjectedState("lambda", "invocation", id)` into Lambda handler

## 5. SDK Helpers
- [ ] 5.1 Add `SetChaos(service string, errorRate float64, latencyMs int) error` to Go SDK session
- [ ] 5.2 Add `ResetChaos(service string) error` to Go SDK session
- [ ] 5.3 Add `GetChaosStatus(service string) (map[string]interface{}, error)` to Go SDK session
- [ ] 5.4 Add `InjectState(service, resourceType, resourceID, state string) error` to Go SDK session
- [ ] 5.5 Add `ClearInjectedState(service, resourceType, resourceID string) error` to Go SDK session
- [ ] 5.6 Add `Client("fake")` / `Client("aws_fake")` to return clients for registered fake server endpoints

## 6. GitHub Actions — E2E suite parallelization
- [ ] 6.1 Add `go-sdk-e2e-suites` discovery job to `.github/workflows/ci.yml` (mirrors `python-sdk-e2e-suites`)
- [ ] 6.2 Add `go-sdk-e2e-test` matrix job consuming `go-sdk-e2e-suites.outputs.suites` with `fail-fast: false`
- [ ] 6.3 Verify `make e2e-test SUITE=<name>` works in `lang/go/sdk/` (or add it to the Makefile if missing)
- [ ] 6.4 Confirm existing `go-sdk-test` (unit/integration) is preserved and only E2E is split out

## 7. Tests and Verification
- [ ] 7.1 Verify `chaos`, `aws_fake`, `fake` E2E test files in `lang/go/sdk/tests/` have non-stub scenarios
- [ ] 7.2 Add unit tests for new state methods (`RegisterFakeServer`, `SetInjectedState`, per-service chaos/capacity)
- [ ] 7.3 Run `make test` in `lang/go/core/` and `lang/go/sdk/` — all green
