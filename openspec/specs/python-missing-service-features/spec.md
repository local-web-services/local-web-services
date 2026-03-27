# python-missing-service-features Specification

## Purpose
TBD - created by archiving change add-python-missing-service-features. Update Purpose after archive.
## Requirements
### Requirement: Glacier Multipart Upload

The Glacier provider SHALL implement multipart upload: `initiate_multipart_upload` returns an upload ID, `upload_multipart_part` stores parts indexed by upload ID and byte range, `complete_multipart_upload` assembles all parts into a stored archive, `abort_multipart_upload` discards the pending upload, and `list_multipart_uploads` / `list_parts` enumerate in-progress uploads.

#### Scenario: Multipart upload completed successfully

- **GIVEN** a vault exists
- **WHEN** a multipart upload is initiated, parts are uploaded, and the upload is completed
- **THEN** an archive ID is returned and the archive is retrievable

#### Scenario: Aborted upload is discarded

- **GIVEN** a multipart upload is in progress
- **WHEN** `abort_multipart_upload` is called
- **THEN** `list_multipart_uploads` no longer returns the upload

### Requirement: Glacier Vault Notifications

The Glacier provider SHALL implement `set_vault_notifications`, `get_vault_notifications`, and `delete_vault_notifications`. When vault notifications are configured with an SNS topic ARN, the provider SHALL publish an SNS notification to the configured topic when relevant vault events occur (job completed, inventory updated).

#### Scenario: Notification published on job completion

- **GIVEN** vault notifications are configured with an SNS topic ARN
- **WHEN** a retrieval job completes
- **THEN** an SNS notification is published to the configured topic

### Requirement: Glacier Archive Retrieval Jobs

The Glacier provider SHALL implement `initiate_job` (type=archive-retrieval), `describe_job`, and `get_job_output`. After a job is initiated, it SHALL transition asynchronously to Succeeded and make the archive body available via `get_job_output`.

#### Scenario: Archive retrieved via job

- **GIVEN** an archive exists in a vault
- **WHEN** an archive retrieval job is initiated and succeeds
- **THEN** `get_job_output` returns the archive body

### Requirement: Neptune Cluster Operations

The Neptune provider SHALL implement `stop_db_cluster`, `start_db_cluster`, `failover_db_cluster`, replica promotion, and cluster snapshot create/delete/restore operations.

#### Scenario: Cluster stopped and restarted

- **GIVEN** a Neptune cluster is AVAILABLE
- **WHEN** `stop_db_cluster` is called followed by `start_db_cluster`
- **THEN** the cluster returns to AVAILABLE state

### Requirement: ElastiCache SNS Notifications

The ElastiCache provider SHALL support configuring an SNS topic ARN on a replication group via `modify_replication_group`. When configured, the provider SHALL publish SNS notifications on cluster events (MODIFYING, AVAILABLE, failover). The provider SHALL also implement `test_failover`.

#### Scenario: SNS notification on cluster modification

- **GIVEN** a replication group has an SNS topic ARN configured
- **WHEN** the cluster transitions to MODIFYING state
- **THEN** an SNS notification is published to the configured topic

### Requirement: DynamoDB Transaction Conflict Resolution

The DynamoDB provider SHALL detect when two concurrent `transact_write_items` calls modify the same item and fail the losing transaction with `TransactionCanceledException` containing a `TransactionConflictException` cancellation reason.

#### Scenario: Concurrent transaction conflict fails one transaction

- **GIVEN** two `transact_write_items` calls both target the same item
- **WHEN** they are executed concurrently
- **THEN** one succeeds and the other fails with TransactionCanceledException

### Requirement: API Gateway Stage Throttling

The API Gateway provider SHALL enforce per-stage throttling when `default_route_settings.throttling_rate_limit` or `throttling_burst_limit` is configured. When the limit is exceeded, the provider SHALL return HTTP 429.

#### Scenario: Request throttled when rate limit exceeded

- **GIVEN** a stage has throttling configured with a limit
- **WHEN** requests exceed the configured rate
- **THEN** excess requests receive HTTP 429

### Requirement: Cognito Full Auth Challenge Flow

The Cognito provider SHALL implement the full auth challenge/response lifecycle: `initiate_auth` returning a challenge (e.g. PASSWORD_VERIFIER), `respond_to_auth_challenge` completing the challenge and issuing tokens, session token tracking with expiry, `admin_confirm_sign_up`, `admin_set_user_password`, `admin_update_user_attributes`, and `confirm_sign_up` with a verification code.

#### Scenario: Auth challenge completed returns tokens

- **GIVEN** a user exists in FORCE_CHANGE_PASSWORD state
- **WHEN** `initiate_auth` is called and the returned challenge is responded to correctly
- **THEN** access and ID tokens are returned

#### Scenario: Expired session rejected on respond_to_auth_challenge

- **GIVEN** an auth session has expired
- **WHEN** `respond_to_auth_challenge` is called with the expired session
- **THEN** the operation is rejected

