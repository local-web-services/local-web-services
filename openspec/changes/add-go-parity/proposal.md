# Change: Add Go parity with Python management API surface and CI parallelization

## Why

The `parity-check` branch already ported most provider-level feature work to Go (all 19 provider handlers were updated). However three categories remain unimplemented in Go that Python has:

1. **Management API shape differences** — Python exposes per-service REST paths (`/_ldk/chaos/{service}`, `/_ldk/capacity/{service}`). Go uses bulk endpoints (`/_ldk/chaos`, `/_ldk/capacity`). Python also has `/_ldk/state` (state injection) and `/_ldk/fake` (fake server instances) that Go entirely lacks. Go's `/_ldk/aws-fake` is a different concept (fake response rules) and does not cover fake server instances.
2. **SDK helpers** — Python's `LwsSession` exposes `set_chaos`, `reset_chaos`, `get_chaos_status`, `inject_state`, `clear_injected_state`, and `client("fake")` / `client("aws_fake")`. The Go SDK has none of these.
3. **CI E2E parallelization** — Go's `go-sdk-test` runs all 92 suites in a single job. Python received a `python-sdk-e2e-suites` matrix discovery job that fans out to one CI job per suite with `fail-fast: false`. Go needs the equivalent.

## What's Already Done on `parity-check` (context only, not in scope)

All 19 Go provider handlers were updated in commit `f5feadd8`. These are already on the branch and do NOT need to be implemented:

| Provider | Changes Already on Branch |
|----------|--------------------------|
| `apigateway` | Duplicate API name guard; root-resource delete protection; `deleteMethod`/`deleteIntegration` return errors |
| `cognitoidp` | `RESET_REQUIRED` status; duplicate pool name guard; state-based operation guards (confirm, enable, disable, update attrs) |
| `docdb` | XML wire protocol (`sendXML`, cluster/instance/snapshot XML types) |
| `dynamodb` | DynamoDB Streams support; lifecycle dwell tracking; `GetCapacityRule("dynamodb")` enforcement |
| `elasticache` | XML wire protocol (cache cluster, replication group, subnet group, snapshot XML types) |
| `elasticsearch` | Refactored `ServeHTTP` with `routeOperation` dispatch |
| `eventbridge` | Additional event routing |
| `glacier` | SNS notification-configuration routes (`PUT/GET/DELETE .../notification-configuration`) |
| `lambda` | DynamoDB Streams port (`NewHandlerWithPorts`); remove-permission; tag/untag; `PutFunctionConcurrency` |
| `memorydb` | Expanded CRUD coverage |
| `neptune` | XML wire protocol |
| `opensearch` | Refactored handler with connection ID routing |
| `rds` | XML wire protocol (instance, snapshot XML types) |
| `s3tables` | Refactored handler with decoded-path operation routing; bucket ARN extraction |
| `secretsmanager` | Minor response fixes |
| `sns` | SNS target notification dispatch |
| `sqs` | `inFlightCount()` helper |
| `ssm` | Expanded parameter/document operations |
| `stepfunctions` | Update state machine; list-executions ARN filter; `GetCapacityRule("stepfunctions")` enforcement |

The Go state layer (`state/state.go`) also already has `ChaosRule`, `CapacityRule`, `FakeRule`, `LifecycleRule` structs and the bulk management endpoints `/_ldk/chaos`, `/_ldk/lifecycle`, `/_ldk/capacity`, `/_ldk/aws-fake`.

## What Changes (in scope for this proposal)

### 1. Management API — per-service chaos path

Python exposes `GET/PUT/DELETE /_ldk/chaos/{service}`. Go has `GET/POST /_ldk/chaos` (bulk only).

- Add `mux.HandleFunc("/_ldk/chaos/", ...)` with path-param extraction alongside the existing bulk endpoint
- `PUT /_ldk/chaos/{service}` — accept `{"error_rate": float, "latency_ms": int}`, call `state.SetChaosRule(service, "*", rule)`
- `GET /_ldk/chaos/{service}` — return config for that service only
- `DELETE /_ldk/chaos/{service}` — call `state.DisableChaos(service)`

### 2. Management API — per-service capacity path

Python exposes `GET/PUT/DELETE /_ldk/capacity/{service}`. Go has `GET/POST /_ldk/capacity` (bulk only).

- Add `mux.HandleFunc("/_ldk/capacity/", ...)` for per-service access
- `PUT /_ldk/capacity/{service}` — accept `{"slots": int|null}`, call `state.SetCapacityRule`
- `GET /_ldk/capacity/{service}` — return config for that service
- `DELETE /_ldk/capacity/{service}` — reset to unlimited (nil slots)

### 3. Management API — fake server instances (`/_ldk/fake`)

Python's `_management_fake.py` manages named fake server *instances* (name → endpoint URL). Go's `/_ldk/aws-fake` manages fake *response rules* — these are distinct concepts. Go needs the fake-instance API:

- Add `fakeServers map[string]string` to `ServerState`
- Add `RegisterFakeServer(name, endpoint string)`, `GetFakeServer(name string) string`, `ListFakeServers() map[string]string` to `state/state.go`
- Add to `management.go`:
  - `POST /_ldk/fake` — register `{"name": string, "endpoint": string}`
  - `GET /_ldk/fake` — list all registered fake server records
  - `GET /_ldk/fake/{name}` — return a single record

### 4. Management API — state injection (`/_ldk/state`)

Python exposes `PUT/DELETE/GET /_ldk/state/{service}/{resource_type}/{resource_id}`.

- Add `injectedStates map[string]string` (keyed `service:resourceType:resourceId`) to `ServerState`
- Add `SetInjectedState`, `ClearInjectedState`, `GetInjectedState` to `state/state.go`
- Add `mux.HandleFunc("/_ldk/state/", ...)` to `management.go`
- Wire state injection into StepFunctions handler (execution status override) and Lambda handler (invocation status)

### 5. SDK helpers

Add to `lang/go/sdk/` session type:

- `SetChaos(service string, errorRate float64, latencyMs int) error`
- `ResetChaos(service string) error`
- `GetChaosStatus(service string) (map[string]interface{}, error)`
- `InjectState(service, resourceType, resourceID, state string) error`
- `ClearInjectedState(service, resourceType, resourceID string) error`
- `Client("fake")` / `Client("aws_fake")` — return clients pointed at registered fake server endpoints

### 6. GitHub Actions — E2E suite parallelization

Python's CI (`python-sdk-e2e-suites` + `python-sdk-e2e-test` matrix) fans out across 92 suites with `fail-fast: false`. Go's `go-sdk-test` runs all suites sequentially in a single job.

Add to `.github/workflows/ci.yml`:

```yaml
# Discovery job — emits the suite list as a matrix
go-sdk-e2e-suites:
  needs: [changes]
  if: always() && !cancelled() && needs.changes.outputs.go-sdk == 'true'
  runs-on: ubuntu-latest
  outputs:
    suites: ${{ steps.list.outputs.suites }}
  steps:
    - uses: actions/checkout@v4
    - id: list
      run: |
        suites=$(ls lang/go/sdk/tests/*_test.go | \
          sed 's|.*/||;s|_test\.go$||' | \
          jq -R . | jq -sc .)
        echo "suites=$suites" >> $GITHUB_OUTPUT

# Per-suite job replacing the monolithic go-sdk-test
go-sdk-e2e-test:
  needs: [changes, go-sdk-e2e-suites, go-core-lint, go-core-test]
  if: |
    always() && !cancelled() &&
    needs.changes.outputs.go-sdk == 'true' &&
    (needs.go-sdk-e2e-suites.result == 'success' || needs.go-sdk-e2e-suites.result == 'skipped') &&
    (needs.go-core-lint.result == 'success' || needs.go-core-lint.result == 'skipped') &&
    (needs.go-core-test.result == 'success' || needs.go-core-test.result == 'skipped')
  strategy:
    fail-fast: false
    matrix:
      suite: ${{ fromJSON(needs.go-sdk-e2e-suites.outputs.suites) }}
  runs-on: ubuntu-latest
  steps:
    - uses: actions/checkout@v4
    - uses: actions/setup-go@v5
      with:
        go-version: "1.23"
    - name: Run E2E suite
      working-directory: lang/go/sdk
      run: make e2e-test
      env:
        SUITE: ${{ matrix.suite }}
```

The existing `go-sdk-test` job (unit + integration) is kept; `go-sdk-e2e-test` is a new parallel E2E-only job.

## Impact

- Affected specs: `python-fake-chaos-sdk-access`, `python-async-state-injection` (Go equivalents)
- Affected code: `lang/go/core/lws/management.go`, `lang/go/core/lws/state/state.go`, `lang/go/sdk/`, `.github/workflows/ci.yml`
- No breaking changes — new per-service endpoints are additive; existing bulk `/_ldk/chaos` / `/_ldk/capacity` endpoints are preserved
