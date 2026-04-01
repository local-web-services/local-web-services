## 1. FizzBee Formal Specification

- [x] 1.1 Create `lang/specification/core/formal/cloudtrail/cloudtrail.fizz` modelling trail lifecycle states (CREATED/LOGGING/STOPPED/DELETED), the 5-trail capacity limit, event buffering, and S3 delivery invariants
- [x] 1.2 Add `always assertion` for trail state validity (no trail in two states simultaneously)
- [x] 1.3 Add `always assertion` for capacity invariant (never more than 5 active trails)
- [x] 1.4 Add `always assertion` for event ordering (events only buffered while a trail is in LOGGING state or the internal buffer is active)
- [x] 1.5 Add `always eventually assertion` for S3 delivery liveness (events in a LOGGING trail are eventually delivered)
- [x] 1.6 Run `fizz lang/specification/core/formal/cloudtrail/cloudtrail.fizz` and confirm no counterexamples

## 2. Gherkin Informal Specifications

- [x] 2.1 Create `lang/specification/core/informal/cloudtrail/trail_lifecycle.feature` covering CreateTrail, StartLogging, StopLogging, UpdateTrail, DeleteTrail, GetTrail, ListTrails, GetTrailStatus
- [x] 2.2 Create `lang/specification/core/informal/cloudtrail/event_capture.feature` covering management and data event capture for DynamoDB, S3, SQS, SNS, and Lambda (representative sample)
- [x] 2.3 Create `lang/specification/core/informal/cloudtrail/s3_delivery.feature` covering periodic flush, error handling, and log file format
- [x] 2.4 Create `lang/specification/core/informal/cloudtrail/eventbridge_integration.feature` covering opt-in forwarding, rule reactions, and missing bus handling
- [x] 2.5 Create `lang/specification/core/informal/cloudtrail/lookup_events.feature` covering filter-by-event-name, filter-by-resource, time range, and pagination

## 3. CloudTrail Provider Implementation

- [x] 3.1 Create `lang/python/core/src/lws/providers/cloudtrail/` package with `__init__.py`, `provider.py`, `routes.py`, `_cloudtrail_state.py`, `_event_builder.py`, `_s3_delivery.py`
- [x] 3.2 Implement `CloudTrailProvider` class with `start()`, `stop()`, `health_check()`, `flush()` following the Provider pattern; manage trail state (CRUD + logging state machine) and the in-memory event ring buffer
- [x] 3.3 Implement `_event_builder.py`: function `build_cloudtrail_event(service, operation, request, response) -> dict` producing a full CloudTrail event envelope
- [x] 3.4 Implement `_s3_delivery.py`: async background task that flushes the buffer to S3 on a 5-minute interval or high-water mark, writing gzip JSON log files under the standard CloudTrail S3 key path
- [x] 3.5 Implement trail lifecycle wire protocol routes (CreateTrail, UpdateTrail, DeleteTrail, GetTrail, ListTrails, StartLogging, StopLogging, GetTrailStatus, LookupEvents) in `routes.py`
- [x] 3.6 Register `CloudTrailProvider` with the orchestrator and assign it a port offset
- [x] 3.7 Add `ICloudTrail` interface in `lang/python/core/src/lws/interfaces/cloudtrail.py`

## 4. Shared CloudTrail Middleware

- [x] 4.1 Create `lang/python/core/src/lws/providers/_shared/aws_cloudtrail_middleware.py` implementing `AwsCloudTrailMiddleware(BaseHTTPMiddleware)` that: extracts operation name, builds a CloudTrail event from request + response, and calls `provider.record_event()` if a provider is registered
- [x] 4.2 Create `apply_cloudtrail_middleware(app, provider)` factory helper in the same module to add the middleware as the innermost wrapper
- [x] 4.3 Wire `AwsCloudTrailMiddleware` into all 21 provider `routes.py` files using the factory helper (apigateway, cognito, docdb, dynamodb, ecs, elasticache, elasticsearch, eventbridge, glacier, iam, lambda_function_url, lambda_runtime, memorydb, neptune, opensearch, organizations, rds, s3, s3tables, secretsmanager, sns, sqs, ssm, stepfunctions, sts)

## 5. EventBridge Integration

- [x] 5.1 Add `set_eventbridge_provider(provider: IEventBus)` method to `CloudTrailProvider` so the orchestrator can inject the EventBridge dependency
- [x] 5.2 In `record_event()`, if the trail has `EventBridgeEventBusArn` set and the EventBridge provider is available, call `put_events()` synchronously with `Source: aws.cloudtrail`
- [x] 5.3 Wire the EventBridge dependency injection in the orchestrator after both providers are started

## 6. Unit Tests

- [x] 6.1 `tests/unit/test_cloudtrail_provider_create_trail.py` — trail creation, duplicate name, capacity limit
- [x] 6.2 `tests/unit/test_cloudtrail_provider_logging_control.py` — StartLogging, StopLogging, idempotency
- [x] 6.3 `tests/unit/test_cloudtrail_provider_update_trail.py` — S3 bucket update, EventBridge ARN update
- [x] 6.4 `tests/unit/test_cloudtrail_provider_delete_trail.py` — delete existing, delete non-existent
- [x] 6.5 `tests/unit/test_cloudtrail_event_builder_management_event.py` — full envelope fields, error code propagation
- [x] 6.6 `tests/unit/test_cloudtrail_event_builder_data_event.py` — S3 and DynamoDB data event resource ARNs
- [x] 6.7 `tests/unit/test_cloudtrail_s3_delivery_flush.py` — gzip format, S3 key path, retry on failure
- [x] 6.8 `tests/unit/test_cloudtrail_lookup_events_filter.py` — each filter key, time range, pagination
- [x] 6.9 `tests/unit/test_cloudtrail_middleware_no_op.py` — middleware skips silently when provider absent

## 7. Integration Tests

- [x] 7.1 `tests/integration/test_cloudtrail_routes_trail_lifecycle.py` — HTTP wire protocol for all trail CRUD + logging state operations
- [x] 7.2 `tests/integration/test_cloudtrail_routes_lookup_events.py` — LookupEvents HTTP wire protocol with filters and pagination
- [x] 7.3 `tests/integration/test_cloudtrail_middleware_captures_dynamodb.py` — middleware captures a DynamoDB PutItem through the ASGI stack

## 8. E2E Test Suite

- [x] 8.1 Create `lang/python/sdk/tests/e2e/cloudtrail/` suite structure (`__init__.py`, `client.py`, `constants.py`, `conftest.py`, `test_scenarios.py`, `given/`, `when/`, `then/`)
- [x] 8.2 Implement `minimal`-tagged scenarios from `trail_lifecycle.feature`
- [x] 8.3 Implement `minimal`-tagged scenarios from `event_capture.feature` (DynamoDB, S3, SQS capture)
- [x] 8.4 Implement `minimal`-tagged scenarios from `s3_delivery.feature`
- [x] 8.5 Implement `minimal`-tagged scenarios from `eventbridge_integration.feature`
- [x] 8.6 Implement `minimal`-tagged scenarios from `lookup_events.feature`
- [x] 8.7 Implement `guard`-tagged scenarios (capacity limit, duplicate trail, non-existent trail errors)
- [x] 8.8 Implement `sequence`-tagged scenarios (create trail → start logging → make API calls → lookup events → verify S3 delivery)

## 9. Architecture and CI

- [x] 9.1 Add `cloudtrail` to the service name consistency check in `test_service_name_consistency.py`
- [x] 9.2 Verify `test_provider_feature_e2e_coverage.py` picks up the new cloudtrail E2E suite automatically
- [x] 9.3 Confirm `make -C lang/python check` passes (lint + unit + integration + architecture)
- [x] 9.4 Confirm E2E suite passes under `make -C lang/python/sdk test-e2e-minimal SUITE=tests/e2e/cloudtrail`
