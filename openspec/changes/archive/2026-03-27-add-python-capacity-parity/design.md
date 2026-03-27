# Design: Python Core Provider Capacity Parity

## Context

The Python core provider in `lang/python/core/` already contains a capacity abstraction in `_shared/aws_capacity.py`:

- `AwsCapacityConfig` — holds `slots: int | None`; `None` = unlimited, `0` = exhausted
- `is_exhausted` property — returns `True` when `slots == 0`
- Management endpoint at `/_ldk/capacity` (POST to set, GET to read)

Only DynamoDB (`PutItem`, `BatchWriteItem`), Lambda (`Invoke`), and SQS use this system. Every other provider that has `guard_violation_capacity:` annotations in the formal spec either ignores capacity entirely or checks it inconsistently.

## Goals / Non-Goals

- **Goals**
  - Every service and operation that the FizzBee spec marks with `guard_violation_capacity:` MUST check the configured capacity and return the correct AWS error when `slots=0`
  - The capacity system MUST be always-on by default; `slots=None` makes all capacity checks pass, preserving the fast test path
  - The control plane endpoint MUST follow the `/_lws/control/` namespace pattern for consistency with the lifecycle state override endpoint
  - No per-service boilerplate beyond registering the service name with the shared capacity router

- **Non-Goals**
  - Per-resource capacity limits (e.g. per-table throughput) — only service-level binary exhausted/unlimited
  - Capacity that decrements on each operation — the binary model (unlimited or exhausted) is sufficient for fault-tolerance testing

## Decisions

### Decision: `PUT /_lws/control/{service}/capacity` + `DELETE /_lws/control/{service}/capacity`

The existing `/_ldk/capacity` endpoint uses a POST with a complex JSON body `{"service": {"slots": 0}}`. The new lifecycle endpoint uses REST-style `PUT` and `DELETE` on resource-specific paths. Capacity follows the same RESTful pattern:

- `PUT /_lws/control/dynamodb/capacity` with body `{"slots": 0}` — exhausts DynamoDB capacity
- `DELETE /_lws/control/dynamodb/capacity` — resets DynamoDB to unlimited (`slots=None`)
- `GET /_lws/control/{service}/capacity` — returns current capacity config for the service

The shared capacity router is implemented once in `_shared/capacity_control.py` and mounted by each provider. The only per-service code is registering the `AwsCapacityConfig` instance under the service name.

**Alternatives considered:**
- Extend `/_ldk/capacity` with PUT/DELETE: mixes namespaces; the `/_ldk/` prefix is a legacy concept; rejected
- Per-service control endpoints: duplicates routing logic; rejected in favour of shared router

### Decision: binary exhausted/unlimited model

A real AWS service tracks per-account concurrency limits, throttle tokens, etc. For local testing the only use case is: "what happens when this service is at capacity?" Binary `slots=None` (unlimited) vs `slots=0` (exhausted) covers this without implementing a token bucket or counter. The formal spec models capacity as a boolean guard (`guard_violation_capacity:`), not a counter, so binary is sufficient.

**Alternatives considered:**
- Per-operation slot counter that decrements: adds complexity with no spec-level justification; rejected
- Per-resource capacity (e.g. per-table): out of scope; the spec annotates service-level capacity; rejected

### Decision: extend existing `AwsCapacityConfig`

No new data structures are needed. The existing `AwsCapacityConfig` dataclass with `slots: int | None` covers all cases. The new control plane router wraps the existing config objects — providers that already create `AwsCapacityConfig` instances just register them with the new router.

### Decision: shared `check_capacity(config, error_code, status_code)` helper

Each handler that checks capacity currently does:

```python
if self._capacity.is_exhausted:
    return JSONResponse({"__type": "ServiceUnavailableException", ...}, status_code=503)
```

Extract this into a helper in `_shared/capacity_control.py` that returns a `JSONResponse` or raises an exception, eliminating per-handler duplication. The error code and status code vary by service (see mapping below).

### Decision: error codes per service

| Service | Operation category | Error code | HTTP status |
|---------|-------------------|-----------|-------------|
| DynamoDB | reads/writes | `ProvisionedThroughputExceededException` | 400 |
| Lambda | invoke | `TooManyRequestsException` | 429 |
| SQS | send | `OverLimit` | 400 |
| SNS | publish/subscribe | `KMSThrottlingException` | 400 |
| Cognito | auth/signup | `TooManyRequestsException` | 400 |
| Step Functions | start execution | `ServiceUnavailableException` | 503 |
| API Gateway | all invocations | — | 429 (no body) |
| Glacier | jobs/archives | `ServiceUnavailableException` | 503 |

## Risks / Trade-offs

- **CPD risk**: 8 providers wire capacity checks in the same pattern; the `check_capacity()` shared helper absorbs the duplicate guard logic
- **Missing coverage**: the fizz spec has cross-service `guard_violation_capacity:` annotations (e.g. SNS delivery to Lambda when Lambda capacity is exhausted); these cross-service checks require checking the destination service's capacity, not just the source service's — document this in contributing guide
