# Tasks: Cross-Service Dispatch Phase 2

Ordered by recommended delivery (fastest wins first). Each phase is independently deployable.

## Phase A — S3→EventBridge SDK Config (unblock 6 skips, SDK only)

- [ ] A.1 Implement `the bucket has an EventBridge notification configured` step body in `lang/python/sdk/tests/e2e/s3api_events/conftest.py` — call `put_bucket_notification_configuration()` with `EventBridgeConfiguration: {}`
- [ ] A.2 Implement `no event slot is available` step body — use `lws_session.capacity("events").exhaust().apply()`
- [ ] A.3 Implement `the target bus is "DELETED"` step body — create bus, configure notification, delete bus, assert error
- [ ] A.4 Remove `pytest.skip()` calls at lines 127, 132, 208, 267 of `s3api_events/conftest.py`
- [ ] A.5 Add unit tests for each new step function (AAA pattern, `expected_*`/`actual_*` variables, no magic strings)
- [ ] A.6 Verify: `make -C lang/python/sdk e2e-test` — `s3api_events` suite: 0 skips

## Phase B — S3→Lambda Dispatch (unblock 13 skips, Python + Go + TypeScript)

- [ ] B.1 Extend `_validate_notification_targets()` in `lang/python/core/src/lws/providers/s3/_s3_bucket_ops.py` to accept `LambdaFunctionConfigurations` ARNs; validate function exists via `compute_provider.get_function(name)`; return HTTP 400 if not found or `compute_provider` is `None`
- [ ] B.2 Add `compute_providers` parameter to `create_s3_app()` in `lang/python/core/src/lws/providers/s3/routes.py`; thread through to `_put_bucket_notification_configuration`
- [ ] B.3 Add unit tests for Lambda ARN validation in `_validate_notification_targets()` (valid function, missing function, no compute provider)
- [ ] B.4 Add integration test for `PUT /?notification` with `LambdaFunctionConfigurations` block (success + 400 error cases)
- [ ] B.5 Add `lambdaPort int` parameter to `NewHandler()` in `lang/go/core/lws/providers/s3/handler.go`; add Lambda case to `dispatchNotification()` switch that POSTs to `http://127.0.0.1:{lambdaPort}/2015-03-31/functions/{name}/invocations`
- [ ] B.6 Wire `lambdaPort` when constructing S3 handler in `lang/go/core/lws/server.go`
- [ ] B.7 Add `lambdaStore` field and `setLambdaStore()` setter to `S3Store` in `lang/typescript/core/src/providers/s3/index.ts`; add Lambda case to `dispatchNotification()`
- [ ] B.8 Call `s3Store.setLambdaStore(lambdaStore)` in `lang/typescript/core/src/server.ts`
- [ ] B.9 Implement step bodies for 13 skipped steps in `lang/python/sdk/tests/e2e/s3api_lambda/conftest.py`; remove `pytest.skip()` calls
- [ ] B.10 Verify: `make -C lang/python/sdk e2e-test` (s3api_lambda: 0 skips) + `make -C lang/go/core test` + `make -C lang/typescript/core integration-test`

## Phase C — StepFunctions Guard Validation (unblock ~40 skips, Python core)

- [ ] C.1 Add state machine `ACTIVE` status check to `start_execution` in `lang/python/core/src/lws/providers/stepfunctions/provider.py`; raise `StateMachineDoesNotExist` / `ExecutionAlreadyExists` as appropriate
- [ ] C.2 Add SQS queue existence and ACTIVE state pre-flight check to `_service_task_bridge.py` before `sendMessage` dispatch
- [ ] C.3 Add DynamoDB table existence and ACTIVE state pre-flight check before DynamoDB task dispatch
- [ ] C.4 Add SNS topic existence pre-flight check before SNS publish dispatch
- [ ] C.5 Add S3 bucket existence pre-flight check before S3 get/put dispatch
- [ ] C.6 Add capacity exhaustion check (read from provider capacity state) before each service task dispatch; raise `ServiceUnavailableException` when exhausted
- [ ] C.7 Add unit tests for each guard validation case (valid resource, missing resource, wrong lifecycle state, capacity exhausted) — AAA pattern, one test class per file
- [ ] C.8 Remove `pytest.skip()` calls from `stepfunctions_sqs/conftest.py` (up to 8 skips)
- [ ] C.9 Remove `pytest.skip()` calls from `stepfunctions_dynamodb/conftest.py`
- [ ] C.10 Remove `pytest.skip()` calls from `stepfunctions_sns/conftest.py`
- [ ] C.11 Remove `pytest.skip()` calls from `stepfunctions_s3api/conftest.py`
- [ ] C.12 Remove `pytest.skip()` calls from `stepfunctions_ssm/conftest.py`
- [ ] C.13 Remove `pytest.skip()` calls from `stepfunctions_secretsmanager/conftest.py`
- [ ] C.14 Remove `pytest.skip()` calls from `stepfunctions_events/conftest.py`
- [ ] C.15 Verify: `make -C lang/python/sdk e2e-test` — all 7 stepfunctions_* suites show fewer skips; `make -C lang/python/core check`

## Phase D — Lambda Invocation Observability (unblock ~50 skips, Python core)

- [ ] D.1 Parse `X-Invocation-Type` request header in `lang/python/core/src/lws/providers/lambda_runtime/routes.py`; for `Event` type dispatch async and return HTTP 202 with `X-Amzn-RequestId` header
- [ ] D.2 Add `record_async_invocation(invocation_id, function_name, trigger_source)` to Lambda provider; maintain in-memory dict of invocation ID → state (`IN_PROGRESS` → `SUCCESS` | `FAILED`)
- [ ] D.3 Update trigger dispatch paths (SNS, S3, EventBridge, Cognito) to call `record_async_invocation()` and update state on completion
- [ ] D.4 Expose invocation state via `list_function_event_invoke_configs()` or a dedicated endpoint sufficient for SDK step polling
- [ ] D.5 Unit tests for async invocation state machine transitions
- [ ] D.6 Integration tests for `POST /invocations` with `X-Invocation-Type: Event` — returns 202, ID recorded, state transitions
- [ ] D.7 Implement lifecycle polling steps in `sns_lambda/conftest.py`, `s3api_lambda/conftest.py`, `events_lambda/conftest.py`, `cognito_lambda/conftest.py`; remove skips
- [ ] D.8 Verify: `make -C lang/python/sdk e2e-test` — affected suites show ~50 fewer skips; `make -C lang/python/core check`

## Phase E — DynamoDB Stream → Lambda (unblock 12 skips, Python core)

- [ ] E.1 Implement DynamoDB stream record formatter: on `PutItem`/`UpdateItem`/`DeleteItem` in the DynamoDB provider, build a stream record envelope (`{"Records": [{"eventSource": "aws:dynamodb", "dynamodb": {"NewImage": ...}}]}`) if an event source mapping exists for the table
- [ ] E.2 Complete DynamoDB stream polling in `lang/python/core/src/lws/providers/lambda_runtime/event_source_manager.py`; invoke Lambda with the stream record batch
- [ ] E.3 Wire `create_event_source_mapping` API call to register stream ARN → Lambda function ARN in `event_source_manager.py`
- [ ] E.4 Unit tests for stream record formatter (insert, modify, delete event types)
- [ ] E.5 Integration tests for event source mapping creation and stream trigger lifecycle
- [ ] E.6 Remove 12 `pytest.skip()` calls from `lang/python/sdk/tests/e2e/dynamodb_lambda/conftest.py`
- [ ] E.7 Verify: `make -C lang/python/sdk e2e-test` — `dynamodb_lambda`: 0 skips; `make -C lang/python/core check`

## Phase F — API Gateway Service Integrations (unblock ~80 skips, Python core)

- [ ] F.1 Implement integration URI parser in `lang/python/core/src/lws/providers/apigateway/_apigateway_v1_resources.py`: parse `arn:aws:apigateway:{region}:{service}:action/{Action}` and `arn:aws:apigateway:{region}:{service}:path/{path}` URIs
- [ ] F.2 Implement DynamoDB integration dispatch: translate integration request into DynamoDB provider call; map response back to HTTP
- [ ] F.3 Implement SQS integration dispatch: translate to `sqs_provider.send_message()`
- [ ] F.4 Implement SNS integration dispatch: translate to `sns_provider.publish()`
- [ ] F.5 Implement S3 integration dispatch: translate to `s3_provider.get_object()` / `put_object()`
- [ ] F.6 Implement StepFunctions integration dispatch: translate to `sf_provider.start_execution()`
- [ ] F.7 Unit tests for each integration dispatch handler (success path + error mapping)
- [ ] F.8 Integration tests for integration configuration endpoint + execution through each backend
- [ ] F.9 Remove skips from `apigateway_dynamodb/conftest.py`, `apigateway_sns/conftest.py`, `apigateway_sqs/conftest.py`, `apigateway_s3api/conftest.py`, `apigateway_stepfunctions/conftest.py`
- [ ] F.10 Verify: `make -C lang/python/sdk e2e-test` — 5 apigateway_* suites show ~80 fewer skips; `make -C lang/python/core check`

## Phase G — RDS Data API (unblock 198 skips, Python core)

- [ ] G.1 Add `POST /execute` route to `lang/python/core/src/lws/providers/rds/routes.py` handling `ExecuteStatement`; parse `sql`, `parameters`, `database`, `resourceArn`, `secretArn` from JSON body
- [ ] G.2 Create SQLite database per cluster (keyed by cluster ARN) in RDS provider state; initialise on first `CreateDBCluster`
- [ ] G.3 Execute DDL/DML against the per-cluster SQLite backend; return response in RDS Data API format (`{"records": [[{"stringValue": "..."}]]}`)
- [ ] G.4 Unit tests for SQL execution (DDL, SELECT, INSERT, UPDATE, DELETE) and response formatting
- [ ] G.5 Integration tests for `POST /execute` endpoint — valid SQL, syntax error, missing cluster
- [ ] G.6 Remove skips from all `rds*/conftest.py` E2E suites
- [ ] G.7 Verify: `make -C lang/python/sdk e2e-test` — rds* suites show 198 fewer skips; `make -C lang/python/core check`
