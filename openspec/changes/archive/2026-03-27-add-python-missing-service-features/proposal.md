# Change: Add Python missing service features — Glacier multipart, secret rotation, Neptune cluster ops, ESM polling, S3 Tables Iceberg, DynamoDB transactions, and more

## Why

~50 e2e step definitions are skipped due to specific missing features across several services. These are independent gaps that do not fit the cross-cutting capacity, lifecycle, or Lambda integration proposals. Each represents a discrete unimplemented API operation or behaviour.

## What Changes

### Glacier
- Implement multipart upload: `initiate_multipart_upload`, `upload_multipart_part`, `complete_multipart_upload`, `abort_multipart_upload`, `list_multipart_uploads`, `list_parts`.
- Implement vault notifications: `set_vault_notifications`, `get_vault_notifications`, `delete_vault_notifications`. When notifications are configured, emit the configured SNS notification on relevant vault events.
- Implement archive retrieval jobs: `initiate_job` (archive retrieval), `get_job_output`, `describe_job`.
- Implement vault inventory refresh (internal async job trigger).

### SecretsManager
- Implement `rotate_secret` (see also Lambda integration proposal — this covers the non-Lambda rotation path: manual rotation stub).
- Implement recovery window expiry: after `delete_secret` with a recovery window, transition secret to fully deleted after the window.

### Neptune
- Implement `stop_db_cluster` / `start_db_cluster`.
- Implement cluster primary instance reassignment (promote replica to primary).
- Implement `failover_db_cluster`.
- Implement cluster snapshot create/delete/restore.

### ElastiCache
- Implement pre-populating cache entries (SET operations on a newly created cluster).
- Implement ElastiCache SNS notification configuration: `modify_replication_group` with `NotificationTopicArn`.
- Implement automatic failover trigger.

### ESM (Event Source Mapping)
- Implement DynamoDB Streams as an ESM source (complement to SQS ESM in Lambda integration proposal).
- Implement ESM lifecycle states: CREATING → ENABLED → DISABLING → DISABLED → DELETING.
- Implement ESM polling: when ENABLED and DynamoDB Streams has new records, invoke Lambda.

### S3 Tables
- Implement `put_table_maintenance_configuration` / `get_table_maintenance_configuration`.
- Implement table compaction (internal async trigger).
- Implement `start_table_bucket_maintenance`.
- Note: Iceberg client operations (schema evolution, snapshots via Iceberg) are out of scope — they require the Iceberg SDK which is external to lws.

### DynamoDB
- Implement non-deterministic transaction conflict resolution: when two concurrent `transact_write_items` calls conflict, one SHALL fail with `TransactionCanceledException`.

### API Gateway
- Implement `simulate_principal_policy` for testing authorizer flows.
- Implement stage throttling enforcement at the route level.

### Cognito
- Implement full auth challenge/response flow: `initiate_auth` returning challenge, `respond_to_auth_challenge`, session token tracking.
- Implement `admin_confirm_sign_up`.
- Implement `admin_set_user_password`.
- Implement `admin_update_user_attributes`.
- Implement `confirm_sign_up` with verification code.

## Impact

- Affected specs: `python-missing-service-features` (new)
- Affected code: `lang/python/core/src/lws/providers/glacier/routes.py`, `lang/python/core/src/lws/providers/secretsmanager/routes.py`, `lang/python/core/src/lws/providers/neptune/routes.py`, `lang/python/core/src/lws/providers/elasticache/routes.py`, `lang/python/core/src/lws/providers/lambda_runtime/routes.py`, `lang/python/core/src/lws/providers/s3tables/routes.py`, `lang/python/core/src/lws/providers/dynamodb/routes.py`, `lang/python/core/src/lws/providers/apigateway/routes.py`, `lang/python/core/src/lws/providers/cognito/routes.py`
- No breaking changes.
