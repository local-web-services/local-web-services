# Change: Add Python Lambda integration routing — invoke Lambda functions triggered by other services

## Why

~400 e2e step definitions are skipped because lws does not execute Lambda functions when they are triggered by other services. This covers every fan-out integration: EventBridge rules targeting Lambda, SNS subscriptions to Lambda, SQS event source mappings, API Gateway Lambda proxy integrations, Cognito Lambda triggers, SecretsManager rotation triggers, RDS event triggers, and StepFunctions Lambda tasks. Lambda invocation observability (state tracking, success/failure, async retries) is also missing. This is the single largest skip category in the e2e suite.

## What Changes

- **EventBridge → Lambda**: When `put_events` matches an enabled rule with a Lambda target, invoke the Lambda function and record the result.
- **SNS → Lambda**: When `publish` is called and a Lambda subscription exists (confirmed), invoke the subscriber function.
- **SQS → Lambda (ESM)**: Implement an event source mapping poller that reads messages from an SQS queue and invokes the subscribed Lambda function.
- **API Gateway → Lambda**: When a REST API has a Lambda proxy integration configured on a method, route matched requests to `invoke` the target Lambda function and return its response.
- **Cognito → Lambda**: Execute configured Lambda triggers (pre-signup, post-confirmation, pre-token generation, etc.) synchronously during Cognito operations.
- **SecretsManager → Lambda**: Execute configured rotation Lambda when `rotate_secret` is called.
- **RDS → Lambda**: Execute configured event subscription Lambda when RDS events are emitted.
- **StepFunctions → Lambda**: Execute Lambda tasks within state machine executions (this overlaps with the existing StepFunctions task bridge but focuses on observability).
- **Lambda invocation observability**: Track invocation state (IN_PROGRESS, SUCCEEDED, FAILED), async retry state, and expose state via a management API endpoint so e2e `then` steps can assert on outcomes.
- **ESM lifecycle**: Support creating, enabling, disabling, and deleting event source mappings (DynamoDB Streams and SQS).

## Impact

- Affected specs: `python-lambda-integration-routing` (new), `lambda-invocation-observability` (existing — modify)
- Affected code: `lang/python/core/src/lws/providers/events/routes.py`, `lang/python/core/src/lws/providers/sns/routes.py`, `lang/python/core/src/lws/providers/sqs/routes.py`, `lang/python/core/src/lws/providers/apigateway/routes.py`, `lang/python/core/src/lws/providers/cognito/routes.py`, `lang/python/core/src/lws/providers/secretsmanager/routes.py`, `lang/python/core/src/lws/providers/rds/routes.py`, `lang/python/core/src/lws/providers/lambda_runtime/routes.py`
- Requires Docker for Lambda execution (existing test infrastructure already pulls Lambda base images).
- No breaking changes to passing tests.
