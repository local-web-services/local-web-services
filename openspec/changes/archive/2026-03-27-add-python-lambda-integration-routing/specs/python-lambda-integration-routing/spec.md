## ADDED Requirements

### Requirement: Lambda Invocation Observability

The Lambda provider SHALL track the state of every invocation (sync and async) in an in-memory store keyed by function name and invocation ID. States SHALL include IN_PROGRESS, SUCCEEDED, and FAILED. Async invocations SHALL additionally track retry count and DLQ delivery. The management API SHALL expose `GET /management/lambda/invocations/{function_name}` returning the list of invocation records.

#### Scenario: Invocation state recorded after sync invoke

- **WHEN** `invoke` is called with InvocationType=RequestResponse
- **THEN** an invocation record with state SUCCEEDED or FAILED is available at the management endpoint

#### Scenario: Async invocation state recorded

- **WHEN** `invoke` is called with InvocationType=Event
- **THEN** an invocation record transitions through IN_PROGRESS to SUCCEEDED or FAILED

### Requirement: EventBridge to Lambda Routing

When `put_events` matches an enabled EventBridge rule whose target is a Lambda function, the Lambda function SHALL be invoked asynchronously with the event payload. The invocation result SHALL be recorded in the observability store.

#### Scenario: Lambda invoked on matched event

- **GIVEN** an enabled rule targets a Lambda function
- **WHEN** `put_events` is called with a matching event
- **THEN** the Lambda function is invoked and the invocation is recorded

#### Scenario: Lambda not invoked when no rule matches

- **GIVEN** no enabled rule matches the event pattern
- **WHEN** `put_events` is called
- **THEN** no Lambda invocation occurs

### Requirement: SNS to Lambda Routing

When `publish` is called on a topic with a confirmed Lambda subscription, the subscribed Lambda function SHALL be invoked asynchronously with the SNS event payload.

#### Scenario: Lambda invoked on SNS publish

- **GIVEN** a Lambda function is subscribed to an SNS topic (protocol=lambda, confirmed)
- **WHEN** `publish` is called
- **THEN** the Lambda function is invoked with the SNS event payload

### Requirement: SQS Event Source Mapping

The Lambda management API SHALL support creating, listing, updating, and deleting SQS event source mappings. When an ESM is ENABLED, the Lambda provider SHALL poll the source SQS queue and invoke the Lambda function with batched message payloads.

#### Scenario: ESM created and reaches ENABLED state

- **WHEN** `create_event_source_mapping` is called with an SQS queue ARN
- **THEN** the ESM transitions from CREATING to ENABLED

#### Scenario: Messages delivered to Lambda via ESM

- **GIVEN** an ENABLED ESM for an SQS queue
- **WHEN** a message is sent to the queue
- **THEN** the Lambda function is invoked with the message as payload

### Requirement: API Gateway Lambda Proxy Integration

When a REST API method has a Lambda proxy integration (type=AWS_PROXY), incoming HTTP requests matched by that method SHALL be forwarded to the Lambda function as synchronous invocations, and the Lambda response SHALL be returned as the HTTP response.

#### Scenario: Request forwarded to Lambda

- **GIVEN** a REST API method has a Lambda proxy integration
- **WHEN** an HTTP request matches the method
- **THEN** the Lambda function is invoked and its response is returned

### Requirement: Cognito Lambda Triggers

The Cognito provider SHALL invoke configured Lambda triggers at the appropriate points in the user lifecycle. Supported triggers SHALL include: pre-signup, post-confirmation, pre-token-generation, and custom message.

#### Scenario: Pre-signup trigger fires on create_user

- **GIVEN** a user pool has a pre-signup Lambda trigger configured
- **WHEN** `sign_up` is called
- **THEN** the pre-signup Lambda is invoked synchronously before the user is created

### Requirement: SecretsManager Lambda Rotation

The SecretsManager provider SHALL support `rotate_secret`, invoking a configured rotation Lambda through the four rotation phases (createSecret, setSecret, testSecret, finishSecret) and updating the secret version stages on success.

#### Scenario: Secret rotated via Lambda

- **GIVEN** a secret has a rotation Lambda configured
- **WHEN** `rotate_secret` is called
- **THEN** the Lambda is invoked through all four phases and the secret value is updated
