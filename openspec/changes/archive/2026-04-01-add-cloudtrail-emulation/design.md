# Design: AWS CloudTrail Emulation

## Context

LWS services are FastAPI/Starlette ASGI apps. Each service already has an ordered
middleware chain (inner → outer):

```
route handler → RequestLoggingMiddleware → AwsIamAuthMiddleware
              → AwsChaosMiddleware → AwsOperationMockMiddleware
```

CloudTrail events must be recorded for every API call that reaches a route handler,
regardless of whether IAM allows or chaos injects an error. The event must record the
real outcome (success, error, denied).

## Goals / Non-Goals

Goals:
- Capture management and data events for all 21 existing providers via shared middleware
- Provide full CloudTrail event envelope (matches real AWS CloudTrail JSON schema)
- Trail lifecycle with S3 delivery using the existing LWS S3 emulator
- EventBridge forwarding from CloudTrail events to a configured event bus
- LookupEvents API with filtering by event name, resource type, username, and time range
- FizzBee formal spec verifying trail lifecycle invariants and event ordering

Non-Goals:
- CloudTrail Insights (anomaly detection)
- CloudTrail Lake (advanced query engine)
- Cross-region / multi-account trails
- Real S3 server-side encryption (SSE-S3 flag accepted but no actual encryption)
- CloudWatch Logs delivery

## Decisions

### Decision: Middleware placement — innermost position
`AwsCloudTrailMiddleware` is placed **innermost** (just outside the route handler),
after all other middleware. This ensures:
- IAM denial is already decided — the event records `errorCode: AccessDenied`
- Chaos errors are already injected — the event records the chaos error code
- The raw response status and body are available for `responseElements`

Alternative considered: outermost position. Rejected because outermost sees the response
after all middleware transforms it, but cannot easily distinguish which middleware layer
caused the response.

### Decision: In-process event buffer with periodic S3 flush
Events are appended to an in-memory ring buffer (configurable max size, default 10,000).
A background asyncio task flushes the buffer to S3 every 5 minutes (matching real
CloudTrail's ~15 min delivery, but shorter for local dev usability) or when the buffer
reaches a high-water mark (1,000 events).

Alternative considered: synchronous per-request S3 write. Rejected because it adds
latency to every API call and creates a hard dependency on S3 being available.

### Decision: Single shared CloudTrail provider instance
The `CloudTrailProvider` is a singleton managed by the orchestrator. All 21 service
middlewares hold a reference to it and call `provider.record_event(event)`. This avoids
any inter-process communication.

Alternative considered: separate CloudTrail microservice with HTTP calls. Rejected as
over-engineered for an in-process emulator.

### Decision: Trail capacity limit matches AWS (5 trails per region per account)
The FizzBee formal spec and the provider enforce a maximum of 5 trails. Attempts to
create a 6th trail raise `MaximumNumberOfTrailsExceededException` (HTTP 400).

### Decision: EventBridge forwarding is opt-in per trail
`CreateTrail` / `UpdateTrail` accept an optional `CloudWatchLogsLogGroupArn` field;
LWS repurposes this field OR adds a separate `EventBridgeEventBusArn` parameter
(to be specified during `UpdateTrail`). Events are forwarded to the named bus if it
exists in the EventBridge provider. Missing bus → warning log, no error.

### Decision: S3 log file format matches real CloudTrail
Files are written as gzip-compressed JSON: `{"Records": [...]}` with the standard
path format:
```
s3://<bucket>/<prefix>/AWSLogs/<account-id>/CloudTrail/<region>/<YYYY>/<MM>/<DD>/
  <account-id>_CloudTrail_<region>_<YYYYMMDDTHHMMSS>Z_<random>.json.gz
```

## Risks / Trade-offs

- **CPD risk**: 21 provider `routes.py` files each need the same middleware line added.
  Mitigation: use a shared factory function `apply_cloudtrail_middleware(app, provider)`
  so the addition is one import + one call per routes.py, not duplicate logic.
- **Buffer memory**: ring buffer of 10,000 full CloudTrail events (~2 KB each) ≈ 20 MB.
  Acceptable for local dev. Buffer size is configurable.
- **S3 dependency**: delivery fails if the S3 provider is stopped. The buffer continues
  accumulating; delivery resumes when S3 is available. Events are not persisted across
  LWS restarts (local dev trade-off).

## Migration Plan

Existing users: no breaking changes. CloudTrail is a new optional provider. Without a
trail configured, the middleware is a no-op (records events to the internal buffer only,
with no S3 delivery and no EventBridge forwarding).

## Open Questions

- Should `lws cloudtrail` CLI commands mirror `aws cloudtrail` subcommands, or just
  provide a `lws cloudtrail list-events` convenience command? (Defer to implementation.)
- Should the E2E suite test CloudTrail capture for every one of the 21 services, or
  a representative sample? (Representative sample recommended to avoid very long CI runs.)
