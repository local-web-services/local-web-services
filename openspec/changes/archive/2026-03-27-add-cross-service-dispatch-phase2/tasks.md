# Tasks: Cross-Service Dispatch Phase 2

Ordered by recommended delivery (fastest wins first). Each phase is independently deployable.

## Phase A — S3→EventBridge SDK Config (unblock 6 skips, SDK only)

- [x] A.1 Implement `the bucket has an EventBridge notification configured` step body in `lang/python/sdk/tests/e2e/s3api_events/given/bucket_has_eventbridge_notification.py` — calls `put_bucket_notification_configuration()` with `EventBridgeConfiguration: {}`
- [x] A.2 Implement `no event slot is available` step body — uses `lws_session.capacity("events").exhaust().apply()`
- [x] A.3 Implement `the target bus is "DELETED"` step body — creates bus, configures notification, deletes bus
- [ ] A.4 Remove `pytest.skip()` calls from remaining step files — 2 skips remain that require core changes outside this phase: `bus_not_exist_or_not_active.py` (needs EventBridge bus existence validation in S3 handler) and `bucket_already_has_eventbridge_notification.py` (AWS allows idempotent overwrite so rejection is incorrect behaviour)
- [x] A.5 BDD step definitions follow architecture test conventions (AAA pattern, `expected_*`/`actual_*` variables enforced by arch tests)
- [x] A.6 Verify: s3api_events suite passes for the 4 newly-enabled scenarios

## Phase B — S3→Lambda Dispatch (unblock 13 skips, Python + Go + TypeScript)

- [x] B.1 Extend `_validate_notification_targets()` in `lang/python/core/src/lws/providers/s3/_s3_bucket_ops.py` to accept `LambdaFunctionConfigurations` ARNs; validate function exists via `compute_providers`; return HTTP 400 if not found or `compute_provider` is `None`
- [x] B.2 Add `compute_providers` parameter to `create_s3_app()` in `lang/python/core/src/lws/providers/s3/routes.py`; threaded through to `_put_bucket_notification_configuration`
- [x] B.3 Unit tests for Lambda ARN validation in `_validate_notification_targets()` — `test_s3_notification_lambda_validation.py` covers valid function, missing function, no compute provider
- [x] B.4 Integration test for `PUT /?notification` with `LambdaFunctionConfigurations` block — `lang/python/core/tests/integration/test_s3_put_notification_lambda.py`
- [x] B.5 Add `lambdaPort int` parameter to `NewHandler()` in `lang/go/core/lws/providers/s3/handler.go`; Lambda case added to `dispatchNotification()` switch
- [x] B.6 Wire `lambdaPort` when constructing S3 handler in `lang/go/core/lws/server.go`
- [x] B.7 Add `lambdaStore` field and `setLambdaStore()` setter to `S3Store` in `lang/typescript/core/src/providers/s3/index.ts`; Lambda case added to `dispatchNotification()`
- [x] B.8 Call `s3Store.setLambdaStore(lambdaStore)` in `lang/typescript/core/src/server.ts`
- [ ] B.9 8 skips remain in `s3api_lambda/` — 3 require invocation-ID tracking from S3-triggered async invocations (IDs not returned by `put_object`), 3 are lifecycle-state cascades, 2 cascade from world["_skip"] — not removable without new LWS infrastructure
- [x] B.10 Verify: make -C lang/go/core test and make -C lang/typescript/core integration-test pass

## Phase C — StepFunctions Guard Validation (unblock ~40 skips, Python core)

- [x] C.1 Add state machine `ACTIVE` status check to `start_execution` in `lang/python/core/src/lws/providers/stepfunctions/provider.py`
- [x] C.2 Add SQS queue existence and ACTIVE state pre-flight check in `_service_task_bridge.py` before `sendMessage` dispatch
- [x] C.3 Add DynamoDB table existence and ACTIVE state pre-flight check before DynamoDB task dispatch
- [x] C.4 Add SNS topic existence pre-flight check before SNS publish dispatch
- [x] C.5 Add S3 bucket existence pre-flight check before S3 get/put dispatch
- [x] C.6 Add capacity exhaustion check before each service task dispatch; raises `ServiceUnavailableException` when exhausted
- [x] C.7 Unit tests for each guard validation case — `test_stepfunctions_service_task_bridge_capacity_*.py` and `test_stepfunctions_*_target_validation.py` files cover valid resource, missing resource, capacity exhausted
- [ ] C.8 Skips remain in `stepfunctions_sqs/` — primarily "sequence setup" given-steps that require pre-configuring internal execution state (e.g., "Cannot pre-set a completed execution SQS task state for sequence setup") and lifecycle states not simulatable externally
- [ ] C.9 Skips remain in `stepfunctions_dynamodb/` — same sequence setup and lifecycle issues
- [ ] C.10 Skips remain in `stepfunctions_sns/` — same
- [ ] C.11 Skips remain in `stepfunctions_s3api/` — same
- [ ] C.12 Skips remain in `stepfunctions_ssm/` — same
- [ ] C.13 Skips remain in `stepfunctions_secretsmanager/` — same
- [ ] C.14 Skips remain in `stepfunctions_events/` — same; EventBridge publishing configuration state not observable
- [x] C.15 Verify: make -C lang/python/core check passes

## Phase D — Lambda Invocation Observability (unblock ~50 skips, Python core)

- [x] D.1 Parse `X-Amz-Invocation-Type` request header in `lang/python/core/src/lws/providers/lambda_runtime/routes.py`; for `Event` type dispatches async and returns HTTP 202 with `X-Amzn-RequestId` header
- [x] D.2 Add `record_async_invocation(invocation_id, ...)` to Lambda provider state (`_LambdaState`); maintains in-memory dict of invocation ID → state (`IN_PROGRESS` → `SUCCESS` | `FAILED`)
- [x] D.3 Async invocation dispatched via `asyncio.create_task(run_async_invocation(...))` which updates state on completion
- [x] D.4 Expose invocation state via `GET /lws/invocations/{invocation_id}` endpoint in Lambda management routes
- [x] D.5 Unit tests for async invocation state machine transitions — `test_lambda_async_invocation.py`
- [x] D.6 Integration tests for `POST /invocations` with `X-Invocation-Type: Event` — `lang/python/core/tests/integration/lambda_/test_lambda_invocation_type.py`
- [ ] D.7 Lifecycle polling steps not removable in `s3api_lambda/`, `sns_lambda/`, `events_lambda/`, `cognito_lambda/` — S3-triggered Lambda invocations do not return the invocation ID to the caller, so the `/lws/invocations/{id}` endpoint cannot be queried without a separate state-listing endpoint
- [x] D.8 Verify: make -C lang/python/core check passes

## Phase E — DynamoDB Stream → Lambda (unblock 12 skips, Python core)

- [x] E.1 DynamoDB stream record formatter: on `PutItem`/`UpdateItem`/`DeleteItem`, builds a stream record envelope and passes it to registered stream handlers if an event source mapping exists
- [x] E.2 DynamoDB stream polling completed in `lang/python/core/src/lws/providers/lambda_runtime/event_source_manager.py`; invokes Lambda with stream record batches via `StreamDispatcher`
- [x] E.3 `create_event_source_mapping` API wires stream ARN → Lambda function via `EventSourceManager.activate()`
- [x] E.4 Unit tests for stream record formatter — `test_dynamodb_streams_build_stream_record.py`, `test_dynamodb_streams_stream_record.py`, `test_dynamodb_streams_stream_view_type_filtering.py`, `test_dynamodb_streams_lambda_invocation_format.py`
- [x] E.5 Integration tests for event source mapping creation and stream trigger lifecycle — `lang/python/core/tests/integration/test_dynamodb_event_source_mapping.py`
- [ ] E.6 17 skips remain in `dynamodb_lambda/` — most are "sequence setup" given-steps (cannot pre-set a completed ESM poll/invocation state externally) plus invocation state observation cascades
- [x] E.7 Verify: make -C lang/python/core check passes

## Phase F — API Gateway Service Integrations (unblock ~80 skips, Python core)

- [x] F.1 Integration URI parser implemented in `lang/python/core/src/lws/providers/apigateway/_apigateway_v1_dispatch.py`: handles `arn:aws:apigateway:{region}:{service}:action/{Action}` and `arn:aws:apigateway:{region}:{service}:path/{path}` URIs
- [x] F.2 DynamoDB integration dispatch: translates to `provider.put_item()` / `provider.get_item()`
- [x] F.3 SQS integration dispatch: translates to `sqs_provider.send_message()`
- [x] F.4 SNS integration dispatch: translates to `sns_provider.publish()`
- [x] F.5 S3 integration dispatch: translates to `s3_provider.put_object()`
- [x] F.6 StepFunctions integration dispatch: translates to `sf_provider.start_execution()`
- [x] F.7 Unit tests for each integration dispatch handler — `test_apigateway_integration_dispatch.py`
- [x] F.8 Integration tests for integration configuration + execution through each backend — `lang/python/core/tests/integration/apigateway/test_apigateway_service_integration.py`
- [ ] F.9 74 skips remain across 5 apigateway_* suites — primarily lifecycle states ("Cannot simulate non-ACTIVE REST API/table/queue/topic"), sequence setup given-steps, and capacity result observation; these require lifecycle state simulation infrastructure beyond this phase
- [x] F.10 Verify: make -C lang/python/core check passes

## Phase G — RDS Data API (unblock 198 skips, Python core)

- [x] G.1 Add `POST /execute` route to `lang/python/core/src/lws/providers/rds/routes.py` handling `ExecuteStatement`; parses `sql`, `parameters`, `database`, `resourceArn`, `secretArn` from JSON body
- [x] G.2 SQLite database per cluster created in RDS provider state (`_RdsState`); initialised on first `CreateDBCluster` via `get_or_create_cluster_db()`
- [x] G.3 DDL/DML executed against per-cluster SQLite backend via `_rds_data_api.handle_execute_statement()`; response formatted as RDS Data API format (`{"records": [[{"stringValue": "..."}]]}`)
- [x] G.4 Unit tests for SQL execution — `test_rds_data_api_execute.py` covers DDL, SELECT, INSERT, type mapping, unknown cluster
- [x] G.5 Integration tests for `POST /execute` endpoint — `lang/python/core/tests/integration/rds/test_rds_execute_statement.py`
- [ ] G.6 `rds*` E2E suites test real DB-instance lifecycle (snapshots, reboots, multi-AZ), RDS event routing, and Lambda invocation from stored procedures — not the Aurora Serverless Data API. Skips in those suites require container-based real MySQL/Postgres support ("lws cluster_db_service does not implement boto3 RDS query protocol") and are out of scope for the Data API implementation.
- [x] G.7 Verify: make -C lang/python/core check passes
