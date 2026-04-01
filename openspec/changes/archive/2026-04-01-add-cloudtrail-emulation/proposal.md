# Change: Add AWS CloudTrail Emulation

## Why
LWS emulates 21 AWS services but has no observability into what API calls were made
against them. Adding CloudTrail emulation gives developers the same audit-trail and
debugging story locally that they rely on in production, without a cloud account.

## What Changes
- New `cloudtrail` provider implementing the CloudTrail wire protocol (CreateTrail,
  UpdateTrail, DeleteTrail, GetTrail, ListTrails, StartLogging, StopLogging, LookupEvents)
- New `AwsCloudTrailMiddleware` added to every service's ASGI middleware chain to capture
  management and data events from all 21 existing providers
- S3 delivery: captured events are written as compressed JSON logs to the LWS S3 emulator
  under the trail's configured S3 bucket prefix
- EventBridge integration: CloudTrail events are forwarded to a configured EventBridge event
  bus so existing EventBridge rules can react to API activity
- Full CloudTrail event structure (userIdentity, sourceIPAddress, requestParameters,
  responseElements, eventType, eventSource, etc.)
- FizzBee formal spec modelling trail lifecycle state machine, event buffering, and S3
  delivery invariants
- Gherkin informal specs driving E2E test scenarios for all behaviours
- Architecture test enforcement that every provider has CloudTrail instrumentation

## Impact
- Affected specs (new): cloudtrail-trail-lifecycle, cloudtrail-event-capture,
  cloudtrail-s3-delivery, cloudtrail-eventbridge-integration, cloudtrail-lookup-events
- Affected code:
  - `lang/python/core/src/lws/providers/cloudtrail/` — new provider
  - `lang/python/core/src/lws/providers/_shared/` — new `aws_cloudtrail_middleware.py`
  - Every provider's `routes.py` — middleware chain updated to include CloudTrail middleware
  - `lang/python/core/src/lws/api/` — CloudTrail provider wired into orchestrator
  - `lang/specification/core/formal/cloudtrail/` — FizzBee spec
  - `lang/specification/core/informal/cloudtrail/` — Gherkin feature files
  - `lang/python/sdk/tests/e2e/cloudtrail/` — new E2E suite
