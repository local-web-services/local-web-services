# Tasks: add-python-cross-service-enforcement

## 1. EventBridge put_events validation

- [ ] 1.1 Reject `put_events` when no enabled rule targets the destination queue/topic/state machine
- [ ] 1.2 Reject `put_events` when the target queue/topic/state machine is not ACTIVE
- [ ] 1.3 Unit tests for each rejection case

## 2. EventBridge put_rule / put_targets validation

- [ ] 2.1 Validate Lambda function existence in `put_targets`
- [ ] 2.2 Validate Lambda function ACTIVE state in `put_targets`
- [ ] 2.3 Validate DynamoDB table existence when creating a rule with DynamoDB target
- [ ] 2.4 Validate SQS queue existence when configuring a StepFunctions SQS task
- [ ] 2.5 Validate SNS topic existence on `delete_topic` (should it fail or be idempotent?)
- [ ] 2.6 Validate state machine target existence when creating a rule
- [ ] 2.7 Unit tests

## 3. SNS enforcement

- [ ] 3.1 Reject `publish` when no confirmed subscription exists for the topic
- [ ] 3.2 Reject `subscribe` (SQS protocol) against a queue that is CREATING or DELETING
- [ ] 3.3 Enforce queue lifecycle state during SNS publish → SQS deliver
- [ ] 3.4 Unit tests

## 4. ElastiCache SNS notification enforcement

- [ ] 4.1 Reject cluster modification/create operations when the configured SNS topic has been deleted
- [ ] 4.2 Unit tests

## 5. Cross-service event bus enforcement

- [ ] 5.1 Cognito: reject operations requiring event bus when bus is deleted
- [ ] 5.2 DocumentDB: reject operations requiring event bus when bus is deleted
- [ ] 5.3 Neptune: reject operations requiring event bus when bus is deleted
- [ ] 5.4 RDS: reject operations requiring event bus when bus is deleted
- [ ] 5.5 SSM: reject parameter operations when event bus is deleted
- [ ] 5.6 SecretsManager: reject `create_secret` / `delete_secret` when event bus is deleted
- [ ] 5.7 StepFunctions: validate EventBridge bus configuration before starting execution
- [ ] 5.8 Unit tests for each service

## 6. SecretsManager / Cognito state checks

- [ ] 6.1 Reject `delete_secret` when secret is already in PENDING_DELETION state
- [ ] 6.2 Reject `admin_delete_user` on an already-deleted user
- [ ] 6.3 Enforce UNCONFIRMED state checks on Cognito verification operations
- [ ] 6.4 Unit tests

## 7. Quality checks

- [ ] 7.1 `make check` passes for `lang/python/core`
- [ ] 7.2 All formerly-skipped cross-service enforcement steps now pass
