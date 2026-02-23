## MODIFIED Requirements

### Requirement: Local Details Column
The Discovered Resources table displayed at `ldk dev` startup SHALL include a "Local Details" column that shows contextual local access information for each resource. For API routes, the column SHALL show the browsable URL combined with the method and handler info. For Lambda functions, the column SHALL show the `ldk invoke <name>` command. For SDK-backed services (DynamoDB, SQS, S3, SNS, EventBridge, Step Functions, Cognito), the column SHALL show copy-pasteable `lws` CLI command snippets for the most common operations on that resource. For ECS services, the column SHALL be empty.

#### Scenario: API route shows browsable URL with method and handler
- **WHEN** an API route resource is displayed in the Discovered Resources table
- **THEN** the Local Details column SHALL show the full local URL (e.g. `http://localhost:3000/orders`) combined with the HTTP method and handler name

#### Scenario: Lambda function shows invoke command
- **WHEN** a Lambda function resource is displayed in the Discovered Resources table
- **THEN** the Local Details column SHALL show `ldk invoke <function-name>`

#### Scenario: DynamoDB table shows lws CLI snippets
- **WHEN** a DynamoDB table resource is displayed in the Discovered Resources table
- **THEN** the Local Details column SHALL show `lws` CLI snippets including `lws dynamodb scan --table-name <name>` and other common operations

#### Scenario: SQS queue shows lws CLI snippets
- **WHEN** an SQS queue resource is displayed in the Discovered Resources table
- **THEN** the Local Details column SHALL show `lws` CLI snippets including `lws sqs send-message --queue-name <name>` and `lws sqs receive-message --queue-name <name>`

#### Scenario: S3 bucket shows lws CLI snippets
- **WHEN** an S3 bucket resource is displayed in the Discovered Resources table
- **THEN** the Local Details column SHALL show `lws` CLI snippets including `lws s3api list-objects-v2 --bucket <name>` and other common operations

#### Scenario: SNS topic shows lws CLI snippets
- **WHEN** an SNS topic resource is displayed in the Discovered Resources table
- **THEN** the Local Details column SHALL show `lws` CLI snippets including `lws sns publish --topic-name <name>`

#### Scenario: EventBridge bus shows lws CLI snippets
- **WHEN** an EventBridge event bus resource is displayed in the Discovered Resources table
- **THEN** the Local Details column SHALL show `lws` CLI snippets including `lws events list-rules --event-bus-name <name>`

#### Scenario: Step Functions state machine shows lws CLI snippets
- **WHEN** a Step Functions state machine resource is displayed in the Discovered Resources table
- **THEN** the Local Details column SHALL show `lws` CLI snippets including `lws stepfunctions start-execution --name <name>`

#### Scenario: Cognito user pool shows lws CLI snippets
- **WHEN** a Cognito user pool resource is displayed in the Discovered Resources table
- **THEN** the Local Details column SHALL show `lws` CLI snippets including `lws cognito-idp sign-up --user-pool-name <name>`
