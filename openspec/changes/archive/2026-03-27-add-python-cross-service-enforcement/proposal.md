# Change: Add Python cross-service enforcement — reject operations when downstream resources are absent or non-ACTIVE

## Why

~25 e2e step definitions are skipped because lws accepts API calls it should reject when a downstream resource is absent, deleted, or not ACTIVE. For example, `put_events` succeeds even when no enabled rule targets the queue, `publish` succeeds even when no confirmed subscription exists, and services like ElastiCache or DocumentDB accept operations even when their associated EventBridge bus has been deleted. AWS enforces these constraints; lws does not.

## What Changes

- EventBridge (`put_events`): Validate that at least one enabled rule targets the destination (queue/topic/state machine) and that the target is ACTIVE before routing the event.
- SNS (`publish`, `subscribe`): Reject `publish` when no confirmed subscription exists for the topic. Reject `subscribe` against an SQS queue that is in CREATING or DELETING state.
- ElastiCache: Reject cluster operations when the configured SNS notification topic has been deleted.
- Cognito, DocumentDB, Neptune, RDS, SSM, SecretsManager: Reject operations that require a live EventBridge bus when the bus has been deleted.
- SecretsManager: Reject `delete_secret` when the secret is already in `PENDING_DELETION` state.
- Cognito: Reject `admin_delete_user` on an already-deleted user. Enforce UNCONFIRMED state checks on verification operations.
- EventBridge `put_rule` / `put_targets`: Validate that referenced Lambda, DynamoDB table, SQS queue, SNS topic, and state machine targets exist before accepting the configuration.
- StepFunctions: Validate EventBridge bus configuration exists before starting an execution that publishes events.

## Impact

- Affected specs: `python-cross-service-enforcement` (new)
- Affected code: `lang/python/core/src/lws/providers/events/routes.py`, `lang/python/core/src/lws/providers/sns/routes.py`, `lang/python/core/src/lws/providers/elasticache/routes.py`, `lang/python/core/src/lws/providers/cognito/routes.py`, `lang/python/core/src/lws/providers/secretsmanager/routes.py`, `lang/python/core/src/lws/providers/stepfunctions/routes.py`
- No breaking changes to passing tests.
