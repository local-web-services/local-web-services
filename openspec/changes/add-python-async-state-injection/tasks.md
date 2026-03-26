# Tasks: add-python-async-state-injection

## 1. Management API — state injection endpoint

- [ ] 1.1 Add `PUT /management/state/{service}/{resource_type}/{resource_id}` accepting `{"state": str}`
- [ ] 1.2 Add `DELETE /management/state/{service}/{resource_type}/{resource_id}` to clear injected state
- [ ] 1.3 Add `GET /management/state/{service}/{resource_type}/{resource_id}` to read current state
- [ ] 1.4 Wire into `create_management_router`
- [ ] 1.5 Unit tests for endpoint

## 2. SDK session — inject_state helpers

- [ ] 2.1 Add `lws_session.inject_state(service, resource_type, resource_id, state)` calling management API
- [ ] 2.2 Add `lws_session.clear_injected_state(service, resource_type, resource_id)`
- [ ] 2.3 Unit tests for SDK helpers

## 3. StepFunctions — injected execution states

- [ ] 3.1 Support injecting RUNNING execution state (execution appears in `list_executions` as RUNNING)
- [ ] 3.2 Support injecting SUCCEEDED / FAILED / TIMED_OUT execution states
- [ ] 3.3 Support injecting pre-completed task states for each service task type (SSM, S3, S3Tables, SNS, SQS, DynamoDB, RDS, OpenSearch, Neptune, MemoryDB, Glacier, Elasticsearch, ElastiCache, DocumentDB, Cognito)
- [ ] 3.4 Unit tests

## 4. Lambda — injected invocation states

- [ ] 4.1 Support injecting IN_PROGRESS invocation (function appears busy)
- [ ] 4.2 Support injecting SUCCEEDED / FAILED invocation history
- [ ] 4.3 Support injecting async retry state
- [ ] 4.4 Unit tests

## 5. Cluster services — injected operational states

- [ ] 5.1 ElastiCache: support MODIFYING, SNAPSHOTTING, RESTORING states
- [ ] 5.2 Neptune: support MODIFYING, SNAPSHOTTING, RESTORING, STOPPING, STOPPED states
- [ ] 5.3 RDS: support MODIFYING, SNAPSHOTTING, RESTORING, STOPPING, STOPPED, FAILING_OVER states
- [ ] 5.4 DocumentDB: support MODIFYING, SNAPSHOTTING, RESTORING states
- [ ] 5.5 MemoryDB: support UPDATING, SNAPSHOTTING, RESTORING states
- [ ] 5.6 Unit tests for each

## 6. EventBridge — injected delivery states

- [ ] 6.1 Support injecting DELIVERED / FAILED event delivery records
- [ ] 6.2 Unit tests

## 7. E2E steps — replace skips

- [ ] 7.1 Implement `no_in_flight_execution_state` given steps using `inject_state("stepfunctions", "execution", ..., "RUNNING")`
- [ ] 7.2 Implement `no_running_execution_state` given steps
- [ ] 7.3 Implement all "Cannot pre-set a completed/failed/running execution X task state" given steps
- [ ] 7.4 Implement `no_in_progress_invocation` given steps (Lambda)
- [ ] 7.5 Implement cluster state setup steps (MODIFYING, RESTORING, SNAPSHOTTING, REBOOTING)
- [ ] 7.6 Add teardown fixtures to clear injected states after tests

## 8. Quality checks

- [ ] 8.1 `make check` passes for `lang/python/core`
- [ ] 8.2 `make check` passes for `lang/python/sdk`
- [ ] 8.3 All formerly-skipped async state injection steps now pass
