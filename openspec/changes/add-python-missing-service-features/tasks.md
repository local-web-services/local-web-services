# Tasks: add-python-missing-service-features

## 1. Glacier — multipart upload

- [x] 1.1 Implement `initiate_multipart_upload` → returns upload ID
- [x] 1.2 Implement `upload_multipart_part` → stores part by upload ID + range
- [x] 1.3 Implement `complete_multipart_upload` → assembles parts, creates archive
- [x] 1.4 Implement `abort_multipart_upload` → deletes pending upload
- [x] 1.5 Implement `list_multipart_uploads` / `list_parts`
- [x] 1.6 Unit tests

## 2. Glacier — vault notifications and jobs

- [x] 2.1 Implement `set_vault_notifications` / `get_vault_notifications` / `delete_vault_notifications`
- [ ] 2.2 Implement internal vault notification trigger → emit SNS message when configured
- [x] 2.3 Implement `initiate_job` (type=archive-retrieval)
- [x] 2.4 Implement `get_job_output` → returns archive body after job succeeds
- [x] 2.5 Implement `describe_job`
- [ ] 2.6 Implement internal vault inventory refresh trigger
- [x] 2.7 Unit tests

## 3. Neptune — cluster operations

- [x] 3.1 Implement `stop_db_cluster` / `start_db_cluster`
- [x] 3.2 Implement `failover_db_cluster`
- [ ] 3.3 Implement replica promotion (primary instance reassignment)
- [x] 3.4 Implement `create_db_cluster_snapshot` / `delete_db_cluster_snapshot` / `restore_db_cluster_from_snapshot`
- [x] 3.5 Unit tests

## 4. ElastiCache — SNS notifications and failover

- [ ] 4.1 Implement `modify_replication_group` accepting `NotificationTopicArn`
- [ ] 4.2 Emit SNS notifications on configured cluster events (MODIFYING, AVAILABLE, etc.)
- [ ] 4.3 Implement automatic failover trigger (internal state transition)
- [ ] 4.4 Implement `test_failover` API
- [ ] 4.5 Unit tests

## 5. ESM — DynamoDB Streams source

- [ ] 5.1 Implement `create_event_source_mapping` for DynamoDB Streams source
- [ ] 5.2 Implement DynamoDB Streams shard polling
- [ ] 5.3 On new DynamoDB records, invoke the mapped Lambda function
- [ ] 5.4 Unit tests

## 6. S3 Tables — maintenance configuration

- [x] 6.1 Implement `put_table_maintenance_configuration`
- [x] 6.2 Implement `get_table_maintenance_configuration`
- [x] 6.3 Implement `start_table_bucket_maintenance` (triggers async compaction)
- [ ] 6.4 Implement internal table compaction completion trigger
- [x] 6.5 Unit tests

## 7. DynamoDB — transaction conflict resolution

- [x] 7.1 Implement optimistic concurrency check in `transact_write_items` when two concurrent transactions modify the same item
- [x] 7.2 Fail the losing transaction with `TransactionCanceledException` / `TransactionConflictException`
- [x] 7.3 Unit tests

## 8. API Gateway — stage throttling

- [x] 8.1 Implement per-stage throttle configuration (`default_route_settings.throttling_rate_limit` / `throttling_burst_limit`)
- [x] 8.2 Track request count per stage; reject with HTTP 429 when throttle limit exceeded
- [x] 8.3 Unit tests

## 9. Cognito — full auth flow

- [x] 9.1 Implement `initiate_auth` returning CHALLENGE_REQUIRED with challenge parameters
- [x] 9.2 Implement `respond_to_auth_challenge` with SRP_A and PASSWORD_VERIFIER challenges
- [x] 9.3 Implement `admin_confirm_sign_up`
- [x] 9.4 Implement `admin_set_user_password`
- [x] 9.5 Implement `admin_update_user_attributes`
- [x] 9.6 Implement `confirm_sign_up` with verification code
- [ ] 9.7 Track session tokens; expire sessions after configured TTL
- [x] 9.8 Unit tests

## 10. Quality checks

- [x] 10.1 `make check` passes for `lang/python/core`
- [x] 10.2 `make check` passes for `lang/python/sdk`
- [ ] 10.3 All formerly-skipped missing-feature steps now pass
