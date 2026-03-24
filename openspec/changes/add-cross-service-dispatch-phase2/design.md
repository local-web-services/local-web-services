# Design: Cross-Service Dispatch Phase 2

## Context

lws emulates AWS cross-service dispatch in-process. Each provider holds references to other providers (injected at startup via `set_*_providers()`). The existing S3→SNS/SQS/EventBridge notification path, the StepFunctions service task bridge, and the Lambda runtime all follow this pattern. Phase 2 extends it to the remaining gaps.

## Goals / Non-Goals

- Goals: eliminate ~399 Python SDK E2E skips; match AWS behaviour for the seven capability areas; keep implementations in Python core as the reference, with Go/TypeScript extended in parallel for S3→Lambda only.
- Non-Goals: full Velocity template engine for API Gateway mappings; multi-region RDS; Lambda concurrent execution limits; Go/TypeScript ports for StepFunctions, DynamoDB stream, Lambda observability, API Gateway, or RDS.

## Decisions

### S3→Lambda: Validation vs Dispatch (Python)

**Decision:** Fix `_validate_notification_targets()` in `_s3_bucket_ops.py` to accept Lambda ARNs and validate the function exists via `compute_provider.get_function(name)`. Do not move validation into the dispatcher.

**Why:** Validation and dispatch are separated by design (validation rejects bad config early; dispatch fires on object PUT). Lambda follows the same pattern as SNS/SQS validation already in place at lines 176–196.

### Go/TypeScript S3→Lambda: HTTP vs In-Process

**Decision:** Go dispatches via HTTP `POST http://127.0.0.1:{lambdaPort}/2015-03-31/functions/{name}/invocations` (matching its existing SQS/SNS/EventBridge pattern). TypeScript dispatches in-process via `lambdaStore.invoke()` (matching its existing SQS/SNS pattern).

**Why:** Each language follows its own established architecture; forcing a common approach would break conventions already validated in Phase 1.

### StepFunctions Guard Validation: Pre-Flight vs Deferred

**Decision:** Add pre-flight checks in `_service_task_bridge.py` before each dispatch, raising the appropriate AWS error immediately.

**Why:** AWS `start_execution` returns `StateMachineDoesNotExist` / `ResourceNotFoundException` synchronously. The current fire-and-forget approach means errors are silently swallowed, causing false-positive test passes.

**Alternatives considered:** Validate only at `start_execution` time (before the engine runs). Rejected: service task target resources can be deleted between execution start and task dispatch; per-dispatch checks are more accurate.

### API Gateway Service Integrations: Simplified Mapping vs Velocity Engine

**Decision:** Implement a simplified URI-pattern dispatcher that handles the specific integration patterns used in the feature files (ARN-based service URIs like `arn:aws:apigateway:{region}:dynamodb:action/PutItem`). No Velocity template engine.

**Why:** A full Velocity engine is a large standalone project. The E2E feature files use a restricted set of patterns; implementing only those unblocks ~80 skips with minimal complexity. A full Velocity engine can be a separate future proposal.

### RDS Data API: SQLite per Cluster

**Decision:** Create one SQLite database file per RDS cluster (keyed by cluster ARN) in the existing RDS provider state directory.

**Why:** Matches the existing DynamoDB/Cognito SQLite pattern; provides full DDL/DML isolation per cluster; no shared schema store that could create cross-cluster interference.

### Lambda Invocation Observability: In-Memory Store

**Decision:** Track async invocation state in an in-memory dict (invocation ID → state) within the Lambda provider.

**Why:** E2E tests run in a single session; SQLite persistence is not needed. Matches the existing SQS/SNS in-memory patterns for ephemeral state.

## Risks / Trade-offs

- S3→Lambda Python: if `compute_provider` is `None` (standalone S3 provider without Lambda), Lambda notification config should be rejected with a clear error rather than silently accepted.
- StepFunctions guard validation: capacity exhaustion checks bypass the HTTP middleware layer (direct provider call). Capacity must be read from the provider's own capacity state, not from an HTTP request.
- API Gateway simplified mappings: any feature file that uses a mapping pattern not in the implemented set will still skip. This is acceptable; those can be handled in Phase 3.
- RDS SQLite: DDL executed in one test scenario persists within the same test session; tests must use unique table names (consistent with the `e2e-*` resource naming convention).

## Migration Plan

No breaking changes to external API surface (AWS wire protocol). The DynamoDB provider internal API change (emitting stream records) is internal only; no SDK migration required.

## Open Questions

None — all design decisions above are resolved.
