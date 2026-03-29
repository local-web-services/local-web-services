# Tasks: remove-python-capacity-lifecycle-skips

## 1. SDK session — capacity helpers

- [ ] 1.1 Add `set_capacity(service, slots)` to `LwsSession` (calls `PUT /management/capacity/{service}`)
- [ ] 1.2 Add `reset_capacity(service)` to `LwsSession` (calls `DELETE /management/capacity/{service}`)
- [ ] 1.3 Unit test `set_capacity` and `reset_capacity`

## 2. SDK session — lifecycle helpers

- [ ] 2.1 Add `set_resource_lifecycle(service, resource_name, state)` to `LwsSession` (calls management API)
- [ ] 2.2 Add `reset_resource_lifecycle(service, resource_name)` to `LwsSession`
- [ ] 2.3 Unit test lifecycle helpers

## 3. Core — lifecycle wiring for remaining services

- [ ] 3.1 Lambda — wire `ResourceLifecycleConfig` for function state (PENDING → ACTIVE → DELETING)
- [ ] 3.2 OpenSearch — wire lifecycle for domain (CREATING → ACTIVE → DELETING)
- [ ] 3.3 Elasticsearch — wire lifecycle for domain
- [ ] 3.4 ElastiCache — wire lifecycle for cluster (CREATING → AVAILABLE → DELETING)
- [ ] 3.5 Neptune — wire lifecycle for cluster (CREATING → AVAILABLE → DELETING)
- [ ] 3.6 RDS — wire lifecycle for DB instance (CREATING → AVAILABLE → DELETING/STOPPING/STOPPED)
- [ ] 3.7 DocumentDB — wire lifecycle for cluster
- [ ] 3.8 MemoryDB — wire lifecycle for cluster, snapshot, ACL, user
- [ ] 3.9 Glacier — wire lifecycle for vault (CREATING → ACTIVE → DELETING) and archive (STORED)
- [ ] 3.10 Cognito — wire lifecycle for user pool
- [ ] 3.11 S3 Tables — wire lifecycle for table bucket and table
- [ ] 3.12 S3 (bucket) — wire lifecycle for bucket (CREATING → ACTIVE → DELETING)
- [ ] 3.13 ApiGateway — wire lifecycle for REST API (CREATING → ACTIVE → DELETING)
- [ ] 3.14 StepFunctions — wire lifecycle for state machine (CREATING → ACTIVE → DELETING)

## 4. E2E steps — capacity (Group 1, ~90 step definitions)

- [ ] 4.1 Implement `no_invocation_slot_available` given steps (Lambda) — use `set_capacity("lambda", 0)`
- [ ] 4.2 Implement `no_execution_slot_available` given steps (StepFunctions) — use `set_capacity("stepfunctions", 0)`
- [ ] 4.3 Implement `no_event_slot_available` given steps (EventBridge) — use `set_capacity("events", 0)`
- [ ] 4.4 Implement `no_message_slot_available` given steps (SQS) — use `set_capacity("sqs", 0)`
- [ ] 4.5 Implement `no_archive_slot_available` / `no_object_slot_available` / `no_document_slot_available` given steps
- [ ] 4.6 Implement `no_cluster_slot_available` / `no_snapshot_slot_available` (MemoryDB)
- [ ] 4.7 Implement `subscription_slot_not_available` (SNS)
- [ ] 4.8 Implement `no_request_slot_available` (ApiGateway) — use `set_capacity("apigateway", 0)`
- [ ] 4.9 Implement throttle-related given/when/then steps for ApiGateway stage endpoints
- [ ] 4.10 Add `capacity_available` teardown fixture to all affected suites to call `reset_capacity` after test

## 5. E2E steps — lifecycle state control (Group 2, ~80 step definitions)

- [ ] 5.1 Implement `non_active_rest_api` given steps (ApiGateway) — use `set_resource_lifecycle("apigateway", api_id, "CREATING")`
- [ ] 5.2 Implement `non_active_table` / `deleting_table` given steps (DynamoDB)
- [ ] 5.3 Implement `non_active_queue` / `non_active_target_queue` given steps (SQS)
- [ ] 5.4 Implement `non_active_topic` given steps (SNS)
- [ ] 5.5 Implement `non_active_state_machine` given steps (StepFunctions)
- [ ] 5.6 Implement `non_active_lambda_function` given steps (Lambda)
- [ ] 5.7 Implement `non_active_opensearch_domain` / `non_available_elasticsearch_domain` given steps
- [ ] 5.8 Implement `non_available_documentdb_cluster` given steps
- [ ] 5.9 Implement `non_available_elasticache_cluster` given steps
- [ ] 5.10 Implement `non_available_memorydb_cluster` / snapshot / ACL / user given steps
- [ ] 5.11 Implement `non_available_neptune_cluster` given steps
- [ ] 5.12 Implement `non_available_rds_instance` / `failing_over` given steps
- [ ] 5.13 Implement `non_active_vault` / `archive_stored` given steps (Glacier)
- [ ] 5.14 Implement `non_active_user_pool` given steps (Cognito)
- [ ] 5.15 Implement `non_active_bucket` / `deleting_bucket` given steps (S3)
- [ ] 5.16 Implement `non_active_table_bucket` given steps (S3 Tables)
- [ ] 5.17 Add lifecycle teardown fixtures to reset state after each test

## 6. Quality checks

- [ ] 6.1 `make check` passes for `lang/python/core`
- [ ] 6.2 `make check` passes for `lang/python/sdk`
- [ ] 6.3 All formerly-skipped capacity steps now pass (not skipped, not failed)
- [ ] 6.4 All formerly-skipped lifecycle steps now pass
