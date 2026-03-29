# Change: Add CloudTrail emulation service

## Why

local-web-services has no CloudTrail support. Applications that record audit events, consume
CloudTrail event history, or rely on trail configuration cannot be tested locally. Adding a
CloudTrail emulator lets developers exercise trail management and event lookup without a real
AWS account.

## What Changes

- New `cloudtrail` provider (Python FastAPI, Go net/http, TypeScript, Java) emulating the
  CloudTrail wire protocol via JSON target dispatch (`X-Amz-Target: CloudTrail_20131101.*`)
- Core operations: `CreateTrail`, `DeleteTrail`, `DescribeTrails`, `GetTrail`,
  `GetTrailStatus`, `StartLogging`, `StopLogging`, `PutEventSelectors`,
  `GetEventSelectors`, `LookupEvents`
- Event recording: the provider records a `CloudTrailEvent` for every API call it receives
  (self-logging); cross-service event injection is out of scope for v1
- `lws cloudtrail` CLI sub-commands: `lookup-events`, `create-trail`, `delete-trail`,
  `describe-trails`, `get-trail-status`
- FizzBee formal spec modelling trail lifecycle and logging state
- Gherkin informal spec generated from the formal spec
- E2E tests across all four SDK languages
- Port offset: `51` (next available after organizations: 50)
- New `contributing/ADDING_A_SERVICE.md` reference guide capturing the full pattern for
  future service additions

## Impact

- Affected specs: `cloudtrail` (new capability)
- Affected code:
  - `lang/python/core/src/lws/providers/cloudtrail/` — Python provider
  - `lang/python/core/src/lws/cli/services/cloudtrail.py` — Python CLI commands
  - `lang/python/core/src/lws/runtime/sdk_env.py` — add `AWS_ENDPOINT_URL_CLOUDTRAIL`
  - `lang/python/core/src/lws/providers/_shared/` — no changes needed (existing middleware reused)
  - `lang/go/core/lws/providers/cloudtrail/` — Go provider
  - `lang/go/core/lws/server.go` — register CloudTrail at offset 51
  - `lang/typescript/core/src/providers/cloudtrail/` — TypeScript provider
  - `lang/java/core/src/main/java/io/localwebservices/lws/providers/cloudtrail/` — Java provider
  - `lang/specification/core/formal/cloudtrail/cloudtrail.fizz` — FizzBee formal spec
  - `lang/specification/core/informal/cloudtrail/` — Gherkin feature files (generated)
  - `lang/python/sdk/tests/e2e/cloudtrail/` — Python E2E tests
  - `lang/go/sdk/tests/bdd_test.go` — wire in CloudTrail Gherkin paths
  - `lang/typescript/core/` — TypeScript test wiring
  - `lang/java/core/src/test/` — Java test wiring
  - `contributing/ADDING_A_SERVICE.md` — new reference guide
