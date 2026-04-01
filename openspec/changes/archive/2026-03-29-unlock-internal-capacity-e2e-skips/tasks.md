# Tasks: unlock-internal-capacity-e2e-skips

## 1. Remove `@internal` conftest filter

- [ ] 1.1 Delete the `pytest_collection_modifyitems` hook from `lang/python/sdk/tests/e2e/conftest.py` that filters out `@internal` scenarios
- [ ] 1.2 Run `make -C lang/python/sdk e2e-test` locally (or in CI) to confirm no new failures — only new SKIPs are expected for cross-service and lifecycle scenarios

## 2. Implement Lambda capacity step definitions

- [ ] 2.1 Implement all 20 `no_invocation_slot_available.py` step files (across lambda_sns, lambda_opensearch, lambda_secretsmanager, lambda_neptune, lambda_glacier, lambda_s3api, lambda_ssm, stepfunctions_lambda, lambda_cognito, etc.) using `lws_session.capacity("lambda").exhaust().apply()`
- [ ] 2.2 Add `lws_session.capacity("lambda").clear()` teardown in each affected suite's conftest or as an autouse fixture

## 3. Implement StepFunctions capacity step definitions

- [ ] 3.1 Implement all 13 `no_execution_slot_available.py` step files (stepfunctions_docdb, stepfunctions_lambda, events_stepfunctions, stepfunctions_opensearch, stepfunctions_elasticache, etc.) using `lws_session.capacity("stepfunctions").exhaust().apply()`
- [ ] 3.2 Add capacity teardown for stepfunctions

## 4. Implement EventBridge (events) capacity step definitions

- [ ] 4.1 Implement all 8 `no_event_slot_available.py` step files (neptune_events, docdb_events, cognito_events, secretsmanager_events, etc.) using `lws_session.capacity("events").exhaust().apply()`
- [ ] 4.2 Add capacity teardown for events

## 5. Implement SNS, S3, and Glacier capacity step definitions

- [ ] 5.1 Implement `subscription_slot_not_available` (sns, sns_sqs) using `lws_session.capacity("sns").exhaust().apply()`
- [ ] 5.2 Implement `delivery_slot_not_available` (sns) and related `delivery_retry_exhausted` / `all_delivery_retries_exhausted` when/then steps
- [ ] 5.3 Implement `no_message_slot_available` (elasticache_sns) using `lws_session.capacity("sns").exhaust().apply()`
- [ ] 5.4 Implement `no_object_slot_available` (lambda_s3api) using `lws_session.capacity("s3").exhaust().apply()`
- [ ] 5.5 Implement `no_archive_slot_available` (lambda_glacier) using `lws_session.capacity("glacier").exhaust().apply()`
- [ ] 5.6 Add capacity teardown for sns, s3, glacier

## 6. Wire capacity to OpenSearch / Elasticsearch

- [ ] 6.1 Add `AwsCapacityConfig` to the OpenSearch provider and mount `CapacityControlPlane`
- [ ] 6.2 Add `AwsCapacityConfig` to the Elasticsearch provider and mount `CapacityControlPlane`
- [ ] 6.3 Implement `no_document_slot_available` (lambda_opensearch) using `lws_session.capacity("opensearch").exhaust().apply()`
- [ ] 6.4 Implement `connection_slot_not_available` (opensearch) using `lws_session.capacity("opensearch").exhaust().apply()`
- [ ] 6.5 Add unit tests for OpenSearch / Elasticsearch capacity enforcement
- [ ] 6.6 Add capacity teardown for opensearch / elasticsearch

## 7. Wire capacity to MemoryDB

- [ ] 7.1 Add `AwsCapacityConfig` to the MemoryDB provider and mount `CapacityControlPlane`
- [ ] 7.2 Implement `target_cluster_slot_not_available`, `snapshot_slot_not_available`, `no_cluster_slot_available`, `no_async_slot_available` step files using `lws_session.capacity("memorydb").exhaust().apply()`
- [ ] 7.3 Add unit tests for MemoryDB capacity enforcement
- [ ] 7.4 Add capacity teardown for memorydb

## 8. Wire capacity to ElastiCache

- [ ] 8.1 Add `AwsCapacityConfig` to the ElastiCache provider and mount `CapacityControlPlane`
- [ ] 8.2 Implement `instance_slot_not_available`, `target_instance_slot_not_available` step files using `lws_session.capacity("elasticache").exhaust().apply()`
- [ ] 8.3 Add unit tests for ElastiCache capacity enforcement
- [ ] 8.4 Add capacity teardown for elasticache

## 9. Wire capacity to Neptune / DocumentDB

- [ ] 9.1 Add `AwsCapacityConfig` to the Neptune provider (via `cluster_db_service`) and mount `CapacityControlPlane`
- [ ] 9.2 Add `AwsCapacityConfig` to the DocumentDB provider and mount `CapacityControlPlane`
- [ ] 9.3 Implement `no_cluster_slot_available_for_primary`, `no_snapshot_slot_available` step files using `lws_session.capacity("neptune").exhaust().apply()` / `lws_session.capacity("docdb").exhaust().apply()`
- [ ] 9.4 Add unit tests for Neptune / DocumentDB capacity enforcement
- [ ] 9.5 Add capacity teardown for neptune / docdb

## 10. Wire capacity to SSM

- [ ] 10.1 Add `AwsCapacityConfig` to the SSM provider and mount `CapacityControlPlane`
- [ ] 10.2 Implement `no_key_slot_available` and `no_record_slot_available` step files using `lws_session.capacity("ssm").exhaust().apply()`
- [ ] 10.3 Add unit tests for SSM capacity enforcement
- [ ] 10.4 Add capacity teardown for ssm

## 11. Deprecate stale proposal

- [ ] 11.1 Archive or close the stale `remove-python-capacity-lifecycle-skips` change — its capacity and filter tasks are now covered here

## 12. Validation

- [ ] 12.1 Run `make -C lang/python/sdk e2e-test` and confirm no skips remain in the "Cannot exhaust" category
- [ ] 12.2 Run `make -C lang/python/core integration-test` and `make -C lang/python/sdk architecture-test` and confirm all pass
- [ ] 12.3 Run `openspec validate unlock-internal-capacity-e2e-skips --strict --no-interactive` and resolve any issues
