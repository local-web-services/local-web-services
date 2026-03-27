# Tasks: add-python-lambda-integration-routing

## 1. Lambda invocation observability (prerequisite)

- [x] 1.1 Add invocation state tracking store to `LambdaRouter` (keyed by function name + invocation ID)
- [x] 1.2 Record IN_PROGRESS, SUCCEEDED, FAILED states on every invoke
- [x] 1.3 Expose invocation history via management API: `GET /management/lambda/invocations/{function_name}`
- [x] 1.4 Expose async retry state via management API
- [x] 1.5 Add SDK helper `lws_session.get_lambda_invocations(function_name)` → list of invocation records
- [x] 1.6 Unit tests for state tracking and management endpoint

## 2. EventBridge → Lambda routing

- [x] 2.1 After `put_events` matches a rule, check if any targets are Lambda functions
- [x] 2.2 Invoke matched Lambda targets asynchronously (InvocationType=Event)
- [x] 2.3 Record invocation result in observability store
- [x] 2.4 Unit tests

## 3. SNS → Lambda routing

- [x] 3.1 When `publish` is called, check for Lambda subscriptions (protocol=lambda) on the topic
- [x] 3.2 Invoke each Lambda subscriber asynchronously with SNS event payload
- [x] 3.3 Unit tests

## 4. SQS → Lambda (Event Source Mapping)

- [x] 4.1 Implement `create_event_source_mapping` route on Lambda management API (SQS source)
- [x] 4.2 Implement `list_event_source_mappings` route
- [x] 4.3 Implement `delete_event_source_mapping` route
- [x] 4.4 Implement `update_event_source_mapping` (enable/disable)
- [x] 4.5 Add background poller: when an ESM is ENABLED, poll the SQS queue and invoke the Lambda function with batch payload
- [x] 4.6 Track ESM state (CREATING → ENABLED → DISABLING → DISABLED → DELETING)
- [x] 4.7 Unit tests for ESM lifecycle and polling

## 5. API Gateway → Lambda proxy integration

- [x] 5.1 When `create_integration` is called with type=AWS_PROXY and uri targeting a Lambda ARN, store the mapping
- [x] 5.2 On incoming HTTP requests, if the matched route has a Lambda integration, invoke the function synchronously and return its response body/status
- [x] 5.3 Unit tests

## 6. Cognito Lambda triggers

- [x] 6.1 Implement pre-signup trigger: invoke configured Lambda before user creation
- [x] 6.2 Implement post-confirmation trigger: invoke after user confirms signup
- [x] 6.3 Implement pre-token-generation trigger: invoke before issuing tokens
- [x] 6.4 Implement custom message trigger
- [x] 6.5 Implement `update_user_pool` to accept `LambdaConfig` setting triggers
- [x] 6.6 Unit tests

## 7. SecretsManager → Lambda rotation

- [x] 7.1 Implement `rotate_secret` route
- [x] 7.2 When rotation is triggered, invoke the configured rotation Lambda with the standard payload phases (createSecret, setSecret, testSecret, finishSecret)
- [x] 7.3 Update secret version stages after successful rotation
- [x] 7.4 Unit tests

## 8. RDS → Lambda event trigger

- [ ] 8.1 Implement `create_event_subscription` route for RDS
- [ ] 8.2 When RDS events are emitted, invoke subscribed Lambda functions
- [ ] 8.3 Unit tests

## 9. Quality checks

- [x] 9.1 `make check` passes for `lang/python/core`
- [x] 9.2 `make check` passes for `lang/python/sdk`
- [x] 9.3 All formerly-skipped Lambda integration steps now pass
