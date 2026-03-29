## Context

CloudTrail is AWS's audit logging service. Applications call `LookupEvents` to query
recorded API activity and use `CreateTrail`/`StartLogging` to direct event storage to S3.
For local development, we need:

1. A service that accepts the CloudTrail wire protocol (JSON target dispatch)
2. In-memory event recording so `LookupEvents` returns a meaningful history
3. Trail management CRUD so SDK calls that configure trails don't fail

Cross-service event injection (i.e. recording when DynamoDB is called) is deferred to v2;
v1 records only calls to the CloudTrail provider itself.

## Goals / Non-Goals

- Goals:
  - Accept real AWS SDK CloudTrail calls redirected via `AWS_ENDPOINT_URL_CLOUDTRAIL`
  - Implement trail CRUD and logging state transitions
  - Implement in-memory event recording and `LookupEvents` with basic attribute filters
  - Implement `PutEventSelectors` / `GetEventSelectors` (stored but not enforced in v1)
  - Full parity across Python, Go, TypeScript, Java providers
  - FizzBee formal spec and generated Gherkin
- Non-Goals:
  - Persisting events to S3 (real CloudTrail behaviour)
  - Cross-service event injection in v1
  - CloudTrail Insights or advanced query features
  - Multi-region trail semantics

## Decisions

- **Wire protocol**: JSON target dispatch (`X-Amz-Target: CloudTrail_20131101.<Action>`)
  via a single `POST /` handler — consistent with SSM, Organizations, DynamoDB, etc.
- **Port offset**: 51 — the next unused offset after organizations (50)
- **Storage**: In-memory dict/map — consistent with SQS, SNS, EventBridge (no persistence needed)
- **Event recording**: On each inbound API call, append a `CloudTrailEvent` entry to an in-memory
  list; `LookupEvents` pages through this list with optional attribute filters
- **Event selectors**: Accept and store `PutEventSelectors` payloads; return them via
  `GetEventSelectors`; not enforced on event recording in v1 (simplest useful implementation)

## Risks / Trade-offs

- In-memory event list will grow unbounded under heavy use; acceptable for local dev, users
  can call `lws cloudtrail` management commands to reset state if needed
- Not recording cross-service events means `LookupEvents` only shows CloudTrail API calls;
  this is still useful for SDK integration tests that call `LookupEvents` after making
  CloudTrail API calls

## Migration Plan

No migration required — this is a new provider. Existing services are unaffected.

## Open Questions

- Should `LookupEvents` support `MaxResults` pagination tokens? Yes, include basic pagination
  (NextToken cursor into the event list) to match SDK expectations.
- Should trail `S3BucketName` be validated against a running local S3 provider? No — accept
  any string in v1 to keep the provider self-contained.
