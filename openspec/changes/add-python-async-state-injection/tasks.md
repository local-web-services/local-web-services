# Tasks: add-python-async-state-injection

## 1. Management API — state injection endpoint

- [x] 1.1 Add `PUT /management/state/{service}/{resource_type}/{resource_id}` accepting `{"state": str}`
- [x] 1.2 Add `DELETE /management/state/{service}/{resource_type}/{resource_id}` to clear injected state
- [x] 1.3 Add `GET /management/state/{service}/{resource_type}/{resource_id}` to read current state
- [x] 1.4 Wire into `create_management_router`
- [x] 1.5 Unit tests for endpoint

## 2. SDK session — inject_state helpers

- [x] 2.1 Add `lws_session.inject_state(service, resource_type, resource_id, state)` calling management API
- [x] 2.2 Add `lws_session.clear_injected_state(service, resource_type, resource_id)`
- [x] 2.3 Unit tests for SDK helpers

## 3. StepFunctions — injected execution states

- [x] 3.1 Support injecting RUNNING execution state (execution appears in `list_executions` as RUNNING)
- [x] 3.2 Support injecting SUCCEEDED / FAILED / TIMED_OUT execution states
- [x] 3.3 Support injecting pre-completed task states for each service task type (SSM, S3, S3Tables, SNS, SQS, DynamoDB, RDS, OpenSearch, Neptune, MemoryDB, Glacier, Elasticsearch, ElastiCache, DocumentDB, Cognito)
- [x] 3.4 Unit tests

## 4. Lambda — injected invocation states

- [x] 4.1 Support injecting IN_PROGRESS invocation (function appears busy)
- [ ] 4.2 Support injecting SUCCEEDED / FAILED invocation history
- [ ] 4.3 Support injecting async retry state
- [ ] 4.4 Unit tests

## 5. Cluster services — injected operational states

- [x] 5.1 ElastiCache: support MODIFYING state
- [x] 5.2 Neptune: support MODIFYING state
- [x] 5.3 RDS: support MODIFYING state
- [x] 5.4 DocumentDB: support MODIFYING state
- [x] 5.5 MemoryDB: support UPDATING state
- [ ] 5.6 Unit tests for each

## 6. EventBridge — injected delivery states

- [ ] 6.1 Support injecting DELIVERED / FAILED event delivery records
- [ ] 6.2 Unit tests

## 7. E2E steps — replace skips

- [x] 7.1 Implement `eid_in_exec_status` given steps using `inject_state("stepfunctions", "execution", ..., "RUNNING")`
- [x] 7.2 Implement running execution stopped/timed_out/terminal given steps
- [x] 7.3 Implement all stepfunctions cross-service `eid_in_exec_status` given steps
- [x] 7.4 Implement `iid_in_inv_status` given steps (Lambda)
- [x] 7.5 Implement cluster state setup steps (MODIFYING for DocDB, Neptune, ElastiCache, MemoryDB, RDS)
- [ ] 7.6 Add teardown fixtures to clear injected states after tests

## 8. Quality checks

- [x] 8.1 `make check` passes for `lang/python/core`
- [x] 8.2 `make check` passes for `lang/python/sdk`
- [ ] 8.3 All formerly-skipped async state injection steps now pass (requires e2e run)
